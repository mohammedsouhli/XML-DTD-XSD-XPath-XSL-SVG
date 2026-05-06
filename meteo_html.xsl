<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <!-- =============================================== -->
    <!-- Template principal : transformation en HTML      -->
    <!-- =============================================== -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Mesures Météorologiques - Maroc</title>
                <meta charset="UTF-8"/>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background-color: #f0f4f8;
                        margin: 20px;
                        color: #333;
                    }
                    h1 {
                        text-align: center;
                        color: #1e5b94;
                        border-bottom: 3px solid #1e5b94;
                        padding-bottom: 10px;
                    }
                    h2 {
                        color: #c0392b;
                        background-color: #fef5e7;
                        padding: 10px;
                        border-left: 5px solid #e67e22;
                        margin-top: 30px;
                    }
                    table {
                        border-collapse: collapse;
                        margin: 15px auto;
                        width: 70%;
                        background-color: white;
                        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                    }
                    th {
                        background-color: #1e5b94;
                        color: white;
                        padding: 12px;
                        text-align: left;
                    }
                    td {
                        padding: 10px 12px;
                        border-bottom: 1px solid #ddd;
                    }
                    tr:nth-child(even) {
                        background-color: #f9f9f9;
                    }
                    tr:hover {
                        background-color: #e8f4fc;
                    }
                    .temp-froide { color: #2980b9; font-weight: bold; }
                    .temp-moyenne { color: #27ae60; font-weight: bold; }
                    .temp-chaude { color: #c0392b; font-weight: bold; }
                </style>
            </head>
            <body>
                <h1>Mesures Météorologiques des Villes Marocaines</h1>
                <!-- Itère sur chaque mesure -->
                <xsl:for-each select="meteo/mesure">
                    <h2>Date de la mesure : <xsl:value-of select="@date"/></h2>
                    <table>
                        <tr>
                            <th>Ville</th>
                            <th>Température (°C)</th>
                        </tr>
                        <!-- Itère sur chaque ville -->
                        <xsl:for-each select="ville">
                            <tr>
                                <td><xsl:value-of select="@nom"/></td>
                                <td>
                                    <!-- Coloration conditionnelle selon la température -->
                                    <xsl:choose>
                                        <xsl:when test="@temperature &lt; 20">
                                            <span class="temp-froide">
                                                <xsl:value-of select="@temperature"/> °C
                                            </span>
                                        </xsl:when>
                                        <xsl:when test="@temperature &lt; 25">
                                            <span class="temp-moyenne">
                                                <xsl:value-of select="@temperature"/> °C
                                            </span>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <span class="temp-chaude">
                                                <xsl:value-of select="@temperature"/> °C
                                            </span>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
