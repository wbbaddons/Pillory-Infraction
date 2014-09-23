{include file='documentHeader'}

<head>
	<title>{lang}wcf.pillory.suspensions{/lang} {if $pageNo > 1}- {lang}wcf.page.pageNo{/lang} {/if}- {PAGE_TITLE|language}</title>
	
	{include file='headInclude'}
</head>

<body id="tpl{$templateName|ucfirst}" data-template="{$templateName}">

{capture assign='sidebar'}
	{include file="pillorySidebar"}
{/capture}

{include file='header' sidebarOrientation='left'}

<header class="boxHeadline">
	<h1>{lang}wcf.pillory.suspensions{/lang}</h1>
</header>

{include file='userNotice'}

<div class="contentNavigation">
	{pages print=true assign=pagesLinks controller='PillorySuspensions' link="pageNo=%d&sortField=$sortField&sortOrder=$sortOrder"}
</div>

{if !$items}
	<p class="info">{lang}wcf.pillory.suspensions.noitems{/lang}</p>
{else}
	<div class="marginTop tabularBox tabularBoxTitle pilloryBanList">
		<header>
			<h2>{lang}wcf.pillory.suspensions{/lang} <span class="badge badgeInverse">{#$items}</span></h2>
		</header>
		
		<table class="table">
			<thead>
				<tr>
					<th colspan="2" class="columnTitle columnUsername{if $sortField == 'userID'} active {@$sortOrder}{/if}"><a href="{link controller='PillorySuspensions'}pageNo={@$pageNo}&sortField=userID&sortOrder={if $sortField == 'userID' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.user.username{/lang}</a></th>
					<th class="columnText columnTitle{if $sortField == 'title'} active {@$sortOrder}{/if}"><a href="{link controller='PillorySuspensions'}pageNo={@$pageNo}&sortField=title&sortOrder={if $sortField == 'title' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.global.title{/lang}</a></th>
					<th class="columnText columnTime{if $sortField == 'time'} active {@$sortOrder}{/if}"><a href="{link controller='PillorySuspensions'}pageNo={@$pageNo}&sortField=time&sortOrder={if $sortField == 'time' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.pillory.time{/lang}</a></th>
					<th class="columnText columnExpires{if $sortField == 'expires'} active {@$sortOrder}{/if}"><a href="{link controller='PillorySuspensions'}pageNo={@$pageNo}&sortField=expires&sortOrder={if $sortField == 'expires' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.infraction.warning.expires{/lang}</a></th>
					{event name='columnHeads'}
				</tr>
			</thead>
			
			<tbody>
				{foreach from=$objects item=suspension}
					<tr class="userSuspension">
						<td class="columnIcon columnAvatar">
							{if $userProfiles[$suspension->userID]->getAvatar()}
								<div>
									<p class="framed">{@$userProfiles[$suspension->userID]->getAvatar()->getImageTag(32)}</p>
								</div>
							{/if}
						</td>
						<td class="columnText columnUsername">
							<h3>
								<a href="{link controller='User' object=$suspension->getUser()}{/link}">{$suspension->getUser()->username}</a>
							</h3>
						</td>
						<td class="columnText columnTitle">{lang}{$suspension->getSuspension()->title}{/lang}</td>
						<td class="columnText columnTime">{@$suspension->time|time}</td>
						<td class="columnText columnExpires">{if $suspension->expires != 0}{@$suspension->expires|plainTime}{else}{lang}wcf.infraction.warning.expires.never.short{/lang}{/if}</td>
						{event name='columns'}
					</tr>
				{/foreach}
			</tbody>
		</table>
	</div>
{/if}

<div class="contentNavigation">
	{@$pagesLinks}
</div>

{include file='footer'}

</body>
</html>