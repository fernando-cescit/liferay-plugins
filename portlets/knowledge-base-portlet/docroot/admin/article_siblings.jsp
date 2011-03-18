<%--
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/admin/init.jsp" %>

<%
Integer status = (Integer)request.getAttribute(WebKeys.KNOWLEDGE_BASE_STATUS);

Article article = (Article)request.getAttribute(WebKeys.KNOWLEDGE_BASE_ARTICLE);

List<Article> siblingArticles = ArticleServiceUtil.getSiblingArticles(scopeGroupId, article.getResourcePrimKey(), status.intValue(), QueryUtil.ALL_POS, QueryUtil.ALL_POS, new ArticlePriorityComparator(true));
%>

<c:if test="<%= !siblingArticles.isEmpty() %>">
	<div class="kb-article-siblings">
		<div class="kb-elements">

			<%
			for (Article siblingArticle : siblingArticles) {
			%>

				<div class="kb-element-header">
					<portlet:renderURL var="viewArticleURL">
						<portlet:param name="jspPage" value='<%= portletConfig.getInitParameter("jsp-path") + "view_article.jsp" %>' />
						<portlet:param name="resourcePrimKey" value="<%= String.valueOf(siblingArticle.getResourcePrimKey()) %>" />
						<portlet:param name="status" value="<%= String.valueOf(status.intValue()) %>" />
					</portlet:renderURL>

					<liferay-ui:icon
						image="../trees/page"
						label="<%= true %>"
						message="<%= siblingArticle.getTitle() %>"
						method="get"
						url="<%= viewArticleURL %>"
					/>
				</div>
				<div class="kb-element-body">

					<%
					request.setAttribute("article_icons.jsp-article", siblingArticle);
					%>

					<liferay-util:include page="/admin/article_icons.jsp" servletContext="<%= application %>" />

					<c:choose>
						<c:when test="<%= Validator.isNotNull(siblingArticle.getDescription()) %>">
							<%= siblingArticle.getDescription() %>
						</c:when>
						<c:otherwise>
							<%= StringUtil.shorten(HtmlUtil.extractText(siblingArticle.getContent()), 500) %>
						</c:otherwise>
					</c:choose>
				</div>

			<%
			}
			%>

		</div>
	</div>
</c:if>