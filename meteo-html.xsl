<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="UTF-8"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Mesures Meteo</title>
				<style>
					body { font-family: Arial, sans-serif; margin: 20px; }
					h1 { color: #2c3e50; text-align: center; }
					h2 { color: #c0392b; margin-top: 30px; }
					table { border-collapse: collapse; margin: 10px 0; width: 50%; }
					th { background-color: #3498db; color: white; padding: 10px; border: 1px solid #2980b9; }
					td { padding: 8px; border: 1px solid #ddd; text-align: center; }
					tr:nth-child(even) { background-color: #f2f2f2; }
				</style>
			</head>
			<body>
				<h1>Mesures des temperatures</h1>
				<xsl:for-each select="meteo/mesure">
					<h2>Date : <xsl:value-of select="@date"/></h2>
					<table>
						<tr>
							<th>Ville</th>
							<th>Temperature (°C)</th>
						</tr>
						<xsl:for-each select="ville">
							<tr>
								<td><xsl:value-of select="@nom"/></td>
								<td><xsl:value-of select="@temperature"/></td>
							</tr>
						</xsl:for-each>
					</table>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
