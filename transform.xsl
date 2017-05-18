<?xml version="1.0"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output omit-xml-declaration="no" indent="yes"/>

	<xsl:template match="/references">
		<xsl:choose>
			<xsl:when test="reference[2]">
				<modsGroup>
					<xsl:apply-templates/>
				</modsGroup>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

	<xsl:template match="reference">
		<mods xmlns="http://www.loc.gov/mods/v3" xmlns:mods="http://www.loc.gov/mods/v3"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xmlns:xlink="http://www.w3.org/1999/xlink">

			<xsl:if test="/references/reference/header">
				<topic>
					<subject>
						<xsl:value-of select="/references/reference/header"/>
					</subject>
				</topic>
			</xsl:if>
			<xsl:if test="title">
				<titleInfo>
					<title>
						<xsl:value-of select="title"/>
					</title>
				</titleInfo>
			</xsl:if>
			<xsl:if test="author">
				<xsl:choose>
					<xsl:when test="contains(author[1],',')">
						<xsl:for-each select="tokenize(author[1],'and ')">
							<name type="personal">
								<xsl:if test="contains(.,',')">
									<namePart type="family">
										<xsl:value-of select="substring-before(., ',')"/>
									</namePart>
									<namePart type="given">
										<xsl:value-of
											select="normalize-space(substring-after(., ','))"/>
									</namePart>
								</xsl:if>
								<role>
									<roleTerm authority="marcrelator" type="text">author</roleTerm>
								</role>
							</name>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<name type="buisness">
							<namePart>
								<xsl:value-of select="author"/>
							</namePart>
							<role>
								<roleTerm authority="marcrelator" type="text">author</roleTerm>
							</role>
						</name>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="location | publisher | date">
				<originInfo>
					<xsl:if test="location">
						<place>
							<placeTerm>
								<xsl:value-of select="location"/>
							</placeTerm>
						</place>
					</xsl:if>
					<xsl:if test="publisher">
						<publisher>
							<xsl:value-of select="publisher"/>
						</publisher>
					</xsl:if>
					<xsl:if test="date and not(journal)">
						<dateIssued>
							<xsl:value-of select="date"/>
						</dateIssued>
					</xsl:if>
					<xsl:if test="date[following-sibling::journal]">
						<dateIssued>
							<xsl:value-of select="date[following-sibling::journal]"/>
						</dateIssued>
					</xsl:if>
				</originInfo>
			</xsl:if>
			<xsl:if test="journal">
				<relatedItem type="host">
					<titleInfo>
						<title>
							<xsl:value-of select="journal"/>
						</title>
					</titleInfo>
					<xsl:if test="volume | pages">
						<part>
							<xsl:if test="volume">
								<xsl:choose>
									<xsl:when test="contains(volume,'(')">
										<detail type="volume">
											<number>
												<xsl:value-of select="substring-before(volume, '(')"
												/>
											</number>
										</detail>
										<detail type="issue">
											<number>
												<xsl:analyze-string select="." regex="\(([^)]+)\)">
												<xsl:matching-substring>
												<xsl:value-of select="regex-group(1)"/>
												</xsl:matching-substring>
												</xsl:analyze-string>
											</number>
										</detail>
									</xsl:when>
									<xsl:otherwise>
										<detail type="volume">
											<number>
												<xsl:value-of select="normalize-space(volume)"/>
											</number>
										</detail>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<xsl:if test="pages">
								<extent unit="pages">
									<xsl:choose>
										<xsl:when test="contains(pages,'-')">
										<start>
											<xsl:value-of select="normalize-space(substring-before(pages, '-'))"/>
										</start>
										<end>
											<xsl:value-of select="normalize-space(substring-after(pages, '-'))"/>
										</end>
											</xsl:when>
										<xsl:otherwise>
											<start>
												<xsl:value-of select="normalize-space(pages)"/>
											</start>
											<end>
												<xsl:value-of select="normalize-space(pages)"/>
											</end>
										</xsl:otherwise>
									</xsl:choose>
								</extent>
							</xsl:if>
							<xsl:if test="date[preceding-sibling::journal]">
								<date>
									<xsl:value-of select="date[preceding-sibling::journal]"/>
								</date>
							</xsl:if>
						</part>
					</xsl:if>
				</relatedItem>
			</xsl:if>
			<xsl:if test="footer">
				<location>
					<physicalLocation>Robertson Library</physicalLocation>
					<holdingSimple>
						<copyInformation>
							<shelfLocator>
								<xsl:value-of select="footer"/>
							</shelfLocator>
						</copyInformation>
					</holdingSimple>
				</location>
			</xsl:if>
		</mods>
	</xsl:template>
</xsl:stylesheet>
