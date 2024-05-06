<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes" />	<!-- El formato de salida será HTML. -->
	<xsl:template match="/">
		<html lang="es">
			<head>
				<meta charset="UTF-8" />
				<meta http-equiv="X-UA-Compatible" content="IE=edge" />
				<meta name="viewport"
					content="width=device-width, initial-scale=1.0" />
				<title>
					<xsl:value-of select="clan/informacion/nombre_clan" /><!-- 
						o solo //nombre_clan -->
				</title>

				<link rel="stylesheet" href="css/plantillaEstilos.css" />
				<!-- gama de colores que se usará en la web, debe ser sustitído por los 
					colores obtenidos de cada xml -->
				<style>
					:root {
					--color-clan:
					<xsl:value-of select="//colores/color[@tipo='clan']" />
					;
					--color-primario:
					<xsl:value-of
						select="//colores/color[@tipo='primario']" />
					;
					--color-secundario:
					<xsl:value-of
						select="//colores/color[@tipo='secundario']" />
					;
					}
				</style>
			</head>

			<body>
				<!-- #### Cabecera de la web #### -->
				<header class="content">
					<div class="picture">
						<img>
							<xsl:attribute name="src">
						
						<xsl:value-of select="clan/informacion/logo" />
						</xsl:attribute>
							<xsl:attribute name="alt">Logo del clan</xsl:attribute>
						</img>
					</div>
					<div class="header-texto">
						<h1>
							<xsl:value-of select="clan/informacion/nombre_clan" />
						</h1>
						<h2>
							<xsl:value-of select="clan/informacion/emblema" />
						</h2>
						<p>
							<xsl:value-of select="clan/informacion/descripcion" />
						</p>
					</div>
				</header>
				<main class="content">
					<h1>Miembros del clan</h1>
					<div class="fichas">
						<xsl:apply-templates
							select="//jugadores/jugador[@rol='principal' or @rol='lider']" />
					</div>
				</main>
				<!-- #### Fin Sección principal #### -->
				<!-- #### Sección secundaria #### -->
				<div class="content fichas">
					<xsl:apply-templates
						select="//jugadores/jugador[@rol='secundario']" />
				</div>
				<!-- #### Fin Sección secundaria #### -->



				<!-- #### Sección estadísticas #### -->
				<div class="content estadisticas">
					<h1>Estadísticas</h1>
					<div class="clasificacion">
						<!-- se muestran los 5 miembros más fuertes del clan ordenados por 
							la habilidad FUE de mayor a menor -->
						<h2>Los 5 más fuertes</h2>
						<ol>
							<xsl:for-each select="//jugador">
								<xsl:sort select="habilidades/habilidad[@cod='FUE']"
									data-type="number" order="descending" />
								<xsl:if test="position()&lt;=5">
									<li>

										<xsl:value-of select="jugador_nombre" />
										<xsl:text>-FUE:</xsl:text>
										<xsl:value-of
											select="habilidades/habilidad[@cod='FUE']" />
									</li>
								</xsl:if>
							</xsl:for-each>
						</ol>
					</div>
					<div class="clasificacion">
						<!-- se muestran los 5 miembros con más nivel del clan ordenados de 
							mayor a menor nivel -->
						<h2>Los 5 con más nivel</h2>
						<ol>
							<xsl:for-each select="//jugador">
								<xsl:sort select="nivel" data-type="number"
									order="descending" />
								<xsl:if test="position() &lt; = 5">
									<li>
										<xsl:value-of select="jugador_nombre" />
										<xsl:text>-NIVEL:</xsl:text>
										<xsl:value-of select="nivel" />


									</li>
								</xsl:if>
							</xsl:for-each>
						</ol>
					</div>
				</div>
				<!-- #### FIN Sección estadísticas #### -->
				<!-- #### Sección grupos #### -->
				<div class="grupos">
					<h1>Grupos</h1>
					<xsl:for-each select="//grupos/grupo">
						<div class="grupo">
							<h2><xsl:value-of select="@nombre"/></h2>
							<article class="ficha miniatura">
								<div class="picture">
									<img src="img/maqueta/img1.jpeg" alt="A1" />
								</div>
								<h5>Nombre Jugador</h5>
							</article>
							<article class="ficha miniatura">
								<div class="picture">
									<img src="img/maqueta/img2.jpeg" alt="A1" />
								</div>
								<h5>Nombre Jugador</h5>
							</article>
						</div>
					</xsl:for-each>
				</div>
				<!-- #### Fin Sección grupos #### -->
				<!-- #### Pié de página #### -->
				<footer>
					<p>El diseño de esta web y el contenido de esta actividad ha sido
						diseñado por</p>
					<h5>P.LLuyot - 2023.</h5>
				</footer>
				<!-- #### Fin Pié de página #### -->
			</body>
		</html>
	</xsl:template>

	<xsl:template match="jugador">
		<article class="ficha {@rol}">
			<div class="picture">
				<img src="{foto}" alt="{jugador_nombre}" />
				<!-- los puntos se calculan sumando todas las habilidades del guerrero -->
				<div class="puntos">
					<xsl:value-of select="sum(habilidades/habilidad)"></xsl:value-of>
				</div>
			</div>
			<h2>
				<xsl:value-of select="jugador_nombre" />
			</h2>
			<h3>
				<xsl:text>Nivel</xsl:text>
				<xsl:value-of select="nivel" />
				<xsl:text> - </xsl:text>
				<xsl:value-of select="raza" />
			</h3>
			<table class="skills-table">
				<tr>
					<th colspan="3">Habilidades</th>
				</tr>
				<xsl:for-each select="habilidades/habilidad">
					<tr>
						<td>
							<xsl:value-of select="@cod"></xsl:value-of>
						</td>
						<td class="progress-item">
							<progress max="10" value="{.}"></progress>
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</article>
	</xsl:template>












</xsl:stylesheet>