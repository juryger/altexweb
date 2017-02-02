<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
    <xsl:output method="html"/>
    <xsl:param name="sum"/>

    <xsl:template match="/">
      <p>Благодарим Вас за то, что сделали заказ на нашем сайте <a href="www.altexweb.ru">www.altexweb.ru</a>. В ближайшее время мы свяжемся с Вами по указанным контактным данным.</p>
      <p>Номер заказа №<strong><xsl:value-of select="/Order/@id"/></strong> от <xsl:value-of select="/Order/@created"/></p>
      <p>
        Получатель:
        <xsl:for-each select="//Customer/Info[@name!='id']">
          <xsl:call-template name="customerInfo" />
        </xsl:for-each>
      </p>
      <table style="border-collapse: collapse;">
        <tr style="border-bottom: 2px solid silver; text-align: left;">
          <th style="padding-left: 5px;">Артикул</th>
          <th style="padding-left: 5px;">Наименование</th>
          <th style="padding-left: 5px;">Ед.измерения</th>
          <th style="padding-left: 5px;">Упаковка</th>
          <th style="padding-left: 5px;">Количество</th>
          <th style="padding-left: 5px;">Цена</th>
          <th style="padding-left: 5px;">Сумма</th>
          <th style="padding-left: 5px;">Комментарий</th>
        </tr>
        <xsl:for-each select="//Details/Item">
          <xsl:call-template name="orderDetail" />        
        </xsl:for-each>
        <tr style="border-top: 2px solid silver;">
          <td colspan="5"></td>
          <td align="right" style="padding-left: 5px; font-weight:bold; font-style:italic;">Итого:</td>
          <td  style="padding-left: 5px; font-weight:bold;">
            <xsl:value-of select="$sum"/> руб.
          </td>
          <td></td>
        </tr>
      </table>
      <br />
      <p>
        ---
        <br />
        С уважением, АЛТЕХ Хозтовары
        <br />
        +7(926)729-34-99, +7(910)911-38-77
        <br />
        AlexTechnologies@gmail.com
      </p>
    </xsl:template>

  <xsl:template name="customerInfo">
    <span><xsl:value-of select="@value"/>, </span>
  </xsl:template>

  <xsl:template name="orderDetail">
    <tr>
      <td style="padding-left: 5px;"><xsl:value-of select="@merchandiseId"/></td>
      <td style="padding-left: 5px;"><xsl:value-of select="@title"/></td>
      <td style="padding-left: 5px;"><xsl:value-of select="@unitMeasure"/></td>
      <td style="padding-left: 5px;"><xsl:value-of select="@pack"/></td>
      <td style="padding-left: 5px;"><xsl:value-of select="@quantity"/></td>
      <td style="padding-left: 5px;"><xsl:value-of select="@cost"/></td>
      <td style="padding-left: 5px;"><xsl:value-of select="@sum"/></td>
      <td style="padding-left: 5px;"><xsl:value-of select="@comment"/></td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>
