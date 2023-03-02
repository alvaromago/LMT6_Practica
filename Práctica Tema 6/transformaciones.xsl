<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="iso-8859-1" omit-xml-declaration="yes"/>

<xsl:template match="/">
    <html>
        <!-- Señalamos la lengua en la que se escribirá el código con el atributo lang -->
        <xsl:attribute name="lang">es</xsl:attribute>
        <head>
            <xsl:apply-templates select="articulo" />
        </head>
        <body>
            <header>
                <h1>
                    <xsl:value-of select="articulo/titulo" />
                </h1>
            </header>
            <section>
                <article>
                    <!-- Creación de la tabla y las columnas que vamos a rellenar -->
                    <table style="width:100%" border="1">
                        <tr style="font-size:125%">
                            <th>Marca</th>
                            <th>Modelo</th>
                            <th>Precio</th>
                            <th>Potencia</th>
                            <th>Capacidad del depósito</th>
                            <th>Velocidad máxima</th>
                        </tr>
                        <!-- Rellenamos esa tabla con los datos que se sacan dentro del template -->
                        <xsl:apply-templates select="articulo/coche" />
                    </table>
                    <!-- Creación de la tabla y columnas que vamos a rellenar -->
                    <table style="width:100%" border="1">
                        <h2>Los modelos ordenados por precio:</h2>
                        <tr style="font-size:125%">
                            <th>Marca</th>
                            <th>Modelo</th>
                            <th>Cilindrada</th>
                        </tr>
                        <!-- Rellenamos ese tabla con los datos que se sacan dentro del template -->
                        <xsl:apply-templates select="articulo/coche/prestaciones">
                            <xsl:sort select="cilindrada" data-type="number" order="descending"/>
                        </xsl:apply-templates>
                    </table>
                    <!-- Con un for-each muestro los datos de los coches con 3 puetas -->
                    <h2>Los coches más vendidos en España en 2020 con 3 puertas:</h2>
                    <ul>
                        <xsl:for-each select="//coche[prestaciones/puertas='tres']">
                        <xsl:if test="prestaciones/puertas='tres'">
                        <li>
                            <xsl:value-of select="marca"/> <xsl:text> </xsl:text> 
                            <xsl:value-of select="modelo"/> (<xsl:text>precio: </xsl:text><xsl:value-of select="@precio"/> <xsl:text> €</xsl:text>)
                        </li>
                        </xsl:if>
                        </xsl:for-each>
                        </ul>
                        <!-- Con un choose muestro los coches con transmision manual de 5 marchas -->
                        <h2>Los coches más vendidos en España en 2020 con transmisión manual de 5 marchas:</h2>
                        <xsl:apply-templates select="articulo/coche/prestaciones/transmision" />
                </article>
            </section>
            <footer style="background-color: #ffff00">
                <p>¡Final del artículo!</p>
                <p>Muchas gracias por haber leido.</p>
                <p>Este artículo ha sido escrito por Álvaro Martín</p>
            </footer>
        </body>
    </html>
</xsl:template>

<!-- Templates aplicados -->
<xsl:template match="articulo">
    <title>
        <xsl:value-of select="@revista" />
    </title>
</xsl:template>

<xsl:template match="articulo/coche">
    <tr>
        <td><xsl:value-of select="marca"/></td>
        <td><xsl:value-of select="modelo"/></td>
        <td><xsl:value-of select="@precio"/> €</td>
        <td><xsl:value-of select="potencia"/></td>
        <td><xsl:value-of select="deposito"/></td>
        <td><xsl:value-of select="velocidad"/> km/h</td>  
    </tr>
</xsl:template>

<xsl:template match="articulo/coche/prestaciones">
    <tr>
        <td>
            
            <xsl:value-of select="../marca" />
        </td>
        <td>
            <xsl:value-of select="../modelo" />
        </td>
        <td>
            <xsl:value-of select="cilindrada"/> cv
        </td>
    </tr>
</xsl:template>

<xsl:template match="articulo/coche/prestaciones/transmision">
    <xsl:choose>
        <xsl:when test="tipo='manual 5'">
            <ul>
                <li>Toyota Corolla</li>
                <li>BMW 325d Berlina</li>
            </ul>
        </xsl:when>
        <xsl:when test="tipo='manual 7'">
            <p>No disponemos de estos modelos en nuestro artículo</p>
        </xsl:when>
    </xsl:choose>
</xsl:template>

</xsl:stylesheet>