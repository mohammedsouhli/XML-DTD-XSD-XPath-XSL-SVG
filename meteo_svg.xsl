<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"
                doctype-public="-//W3C//DTD SVG 1.1//EN"
                doctype-system="http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd"/>

    <!-- ============================================================== -->
    <!-- Template principal : génère un SVG avec histogramme animé       -->
    <!-- ============================================================== -->
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg"
             width="900" height="700"
             viewBox="0 0 900 700">

            <!-- Titre -->
            <text x="450" y="35" text-anchor="middle"
                  font-family="Arial" font-size="22" font-weight="bold"
                  fill="#1e5b94">
                Histogramme des Températures - Villes Marocaines
            </text>

            <!-- Boucle sur chaque mesure : un histogramme par date -->
            <xsl:for-each select="meteo/mesure">
                <xsl:variable name="indexMesure" select="position()"/>
                <!-- Décalage vertical pour chaque mesure -->
                <xsl:variable name="offsetY" select="80 + ($indexMesure - 1) * 310"/>

                <!-- Sous-titre : la date -->
                <text x="450" font-family="Arial" font-size="16" font-weight="bold"
                      fill="#c0392b" text-anchor="middle">
                    <xsl:attribute name="y">
                        <xsl:value-of select="$offsetY"/>
                    </xsl:attribute>
                    Date : <xsl:value-of select="@date"/>
                </text>

                <!-- Axe horizontal (ligne de base) -->
                <line stroke="#333" stroke-width="2">
                    <xsl:attribute name="x1">60</xsl:attribute>
                    <xsl:attribute name="y1"><xsl:value-of select="$offsetY + 220"/></xsl:attribute>
                    <xsl:attribute name="x2">860</xsl:attribute>
                    <xsl:attribute name="y2"><xsl:value-of select="$offsetY + 220"/></xsl:attribute>
                </line>

                <!-- Axe vertical -->
                <line stroke="#333" stroke-width="2">
                    <xsl:attribute name="x1">60</xsl:attribute>
                    <xsl:attribute name="y1"><xsl:value-of select="$offsetY + 20"/></xsl:attribute>
                    <xsl:attribute name="x2">60</xsl:attribute>
                    <xsl:attribute name="y2"><xsl:value-of select="$offsetY + 220"/></xsl:attribute>
                </line>

                <!-- Étiquette de l'axe Y -->
                <text font-family="Arial" font-size="11" fill="#555">
                    <xsl:attribute name="x">15</xsl:attribute>
                    <xsl:attribute name="y"><xsl:value-of select="$offsetY + 25"/></xsl:attribute>
                    T (°C)
                </text>

                <!-- Boucle sur chaque ville : génère une barre -->
                <xsl:for-each select="ville">
                    <xsl:variable name="indexVille" select="position()"/>
                    <!-- Position X de la barre -->
                    <xsl:variable name="x" select="80 + ($indexVille - 1) * 95"/>
                    <!-- Hauteur de la barre : température x 6 pixels -->
                    <xsl:variable name="hauteur" select="@temperature * 6"/>
                    <!-- Position Y du sommet de la barre -->
                    <xsl:variable name="y" select="$offsetY + 220 - $hauteur"/>

                    <!-- Couleur selon la température -->
                    <xsl:variable name="couleur">
                        <xsl:choose>
                            <xsl:when test="@temperature &lt; 20">#3498db</xsl:when>
                            <xsl:when test="@temperature &lt; 25">#27ae60</xsl:when>
                            <xsl:otherwise>#e74c3c</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>

                    <!-- BARRE ANIMÉE : la hauteur croît de 0 à la valeur finale -->
                    <rect width="70" stroke="#333" stroke-width="1">
                        <xsl:attribute name="x"><xsl:value-of select="$x"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="$offsetY + 220"/></xsl:attribute>
                        <xsl:attribute name="height">0</xsl:attribute>
                        <xsl:attribute name="fill"><xsl:value-of select="$couleur"/></xsl:attribute>

                        <!-- Animation de la hauteur (de 0 à hauteur finale) -->
                        <animate attributeName="height"
                                 from="0" dur="2s"
                                 fill="freeze" begin="0.3s">
                            <xsl:attribute name="to"><xsl:value-of select="$hauteur"/></xsl:attribute>
                        </animate>
                        <!-- Animation de la position Y (descend pour rester sur l'axe) -->
                        <animate attributeName="y"
                                 dur="2s"
                                 fill="freeze" begin="0.3s">
                            <xsl:attribute name="from"><xsl:value-of select="$offsetY + 220"/></xsl:attribute>
                            <xsl:attribute name="to"><xsl:value-of select="$y"/></xsl:attribute>
                        </animate>
                    </rect>

                    <!-- Valeur de la température au-dessus de la barre -->
                    <text font-family="Arial" font-size="13" font-weight="bold"
                          text-anchor="middle" fill="#222" opacity="0">
                        <xsl:attribute name="x"><xsl:value-of select="$x + 35"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="$y - 6"/></xsl:attribute>
                        <xsl:value-of select="@temperature"/>°C
                        <!-- Apparition progressive du texte -->
                        <animate attributeName="opacity"
                                 from="0" to="1" dur="1s"
                                 fill="freeze" begin="2.3s"/>
                    </text>

                    <!-- Nom de la ville sous la barre (pivoté) -->
                    <text font-family="Arial" font-size="12" fill="#333">
                        <xsl:attribute name="x"><xsl:value-of select="$x + 35"/></xsl:attribute>
                        <xsl:attribute name="y"><xsl:value-of select="$offsetY + 235"/></xsl:attribute>
                        <xsl:attribute name="text-anchor">middle</xsl:attribute>
                        <xsl:attribute name="transform">
                            rotate(-30, <xsl:value-of select="$x + 35"/>, <xsl:value-of select="$offsetY + 235"/>)
                        </xsl:attribute>
                        <xsl:value-of select="@nom"/>
                    </text>
                </xsl:for-each>
            </xsl:for-each>

            <!-- Légende des couleurs -->
            <g transform="translate(60, 670)">
                <rect x="0" y="-12" width="15" height="15" fill="#3498db"/>
                <text x="22" y="0" font-family="Arial" font-size="12" fill="#333">Froide (&lt; 20°C)</text>

                <rect x="160" y="-12" width="15" height="15" fill="#27ae60"/>
                <text x="182" y="0" font-family="Arial" font-size="12" fill="#333">Moyenne (20-24°C)</text>

                <rect x="340" y="-12" width="15" height="15" fill="#e74c3c"/>
                <text x="362" y="0" font-family="Arial" font-size="12" fill="#333">Chaude (≥ 25°C)</text>
            </g>

        </svg>
    </xsl:template>

</xsl:stylesheet>
