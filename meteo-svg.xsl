<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:svg="http://www.w3.org/2000/svg">

	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

	<xsl:template match="/">
		<svg xmlns="http://www.w3.org/2000/svg" width="900" height="900" viewBox="0 0 900 900">

			<text x="450" y="30" text-anchor="middle" font-family="Arial" font-size="20" font-weight="bold" fill="#2c3e50">
				Histogramme des temperatures
			</text>

			<xsl:for-each select="meteo/mesure">
				<xsl:variable name="indexMesure" select="position()"/>
				<xsl:variable name="offsetY" select="60 + ($indexMesure - 1) * 280"/>

				<text x="450" font-family="Arial" font-size="14" font-weight="bold" fill="#c0392b" text-anchor="middle">
					<xsl:attribute name="y"><xsl:value-of select="$offsetY"/></xsl:attribute>
					Date : <xsl:value-of select="@date"/>
				</text>

				<line stroke="black" stroke-width="1">
					<xsl:attribute name="x1">50</xsl:attribute>
					<xsl:attribute name="y1"><xsl:value-of select="$offsetY + 200"/></xsl:attribute>
					<xsl:attribute name="x2">850</xsl:attribute>
					<xsl:attribute name="y2"><xsl:value-of select="$offsetY + 200"/></xsl:attribute>
				</line>

				<line stroke="black" stroke-width="1">
					<xsl:attribute name="x1">50</xsl:attribute>
					<xsl:attribute name="y1"><xsl:value-of select="$offsetY + 20"/></xsl:attribute>
					<xsl:attribute name="x2">50</xsl:attribute>
					<xsl:attribute name="y2"><xsl:value-of select="$offsetY + 200"/></xsl:attribute>
				</line>

				<xsl:for-each select="ville">
					<xsl:variable name="indexVille" select="position()"/>
					<xsl:variable name="x" select="70 + ($indexVille - 1) * 95"/>
					<xsl:variable name="hauteur" select="@temperature * 3"/>
					<xsl:variable name="y" select="$offsetY + 200 - $hauteur"/>

					<rect width="60" stroke="black" stroke-width="1" fill="steelblue">
						<xsl:attribute name="x"><xsl:value-of select="$x"/></xsl:attribute>
						<xsl:attribute name="y"><xsl:value-of select="$offsetY + 200"/></xsl:attribute>
						<xsl:attribute name="height">0</xsl:attribute>
						<animate attributeName="height" from="0" dur="2s" fill="freeze" begin="0.5s">
							<xsl:attribute name="to"><xsl:value-of select="$hauteur"/></xsl:attribute>
						</animate>
						<animate attributeName="y" dur="2s" fill="freeze" begin="0.5s">
							<xsl:attribute name="from"><xsl:value-of select="$offsetY + 200"/></xsl:attribute>
							<xsl:attribute name="to"><xsl:value-of select="$y"/></xsl:attribute>
						</animate>
					</rect>

					<text font-family="Arial" font-size="12" fill="black" text-anchor="middle" opacity="0">
						<xsl:attribute name="x"><xsl:value-of select="$x + 30"/></xsl:attribute>
						<xsl:attribute name="y"><xsl:value-of select="$y - 5"/></xsl:attribute>
						<xsl:value-of select="@temperature"/>
						<animate attributeName="opacity" from="0" to="1" dur="1s" fill="freeze" begin="2.5s"/>
					</text>

					<text font-family="Arial" font-size="11" fill="black" text-anchor="middle">
						<xsl:attribute name="x"><xsl:value-of select="$x + 30"/></xsl:attribute>
						<xsl:attribute name="y"><xsl:value-of select="$offsetY + 215"/></xsl:attribute>
						<xsl:value-of select="@nom"/>
					</text>
				</xsl:for-each>
			</xsl:for-each>

		</svg>
	</xsl:template>

</xsl:stylesheet>
