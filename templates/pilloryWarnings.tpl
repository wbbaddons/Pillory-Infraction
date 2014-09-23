{include file='documentHeader'}

<head>
	<title>{lang}wcf.pillory.warnings{/lang} {if $pageNo > 1}- {lang}wcf.page.pageNo{/lang} {/if}- {PAGE_TITLE|language}</title>
	
	{include file='headInclude'}
</head>

<body id="tpl{$templateName|ucfirst}" data-template="{$templateName}">

{capture assign='sidebar'}
	{include file="pillorySidebar"}
{/capture}

{include file='header' sidebarOrientation='left'}

<header class="boxHeadline">
	<h1>{lang}wcf.pillory.warnings{/lang}</h1>
</header>

{include file='userNotice'}

<div class="contentNavigation">
	{pages print=true assign=pagesLinks controller='PilloryWarnings' link="pageNo=%d&sortField=$sortField&sortOrder=$sortOrder"}
</div>

{if !$items}
	<p class="info">{lang}wcf.pillory.warnings.noitems{/lang}</p>
{else}
	<div class="marginTop tabularBox tabularBoxTitle pilloryBanList">
		<header>
			<h2>{lang}wcf.pillory.warnings{/lang} <span class="badge badgeInverse">{#$items}</span></h2>
		</header>
		
		<table class="table">
			<thead>
				<tr>
					<th colspan="2" class="columnTitle columnUsername{if $sortField == 'userID'} active {@$sortOrder}{/if}"><a href="{link controller='PilloryWarnings'}pageNo={@$pageNo}&sortField=userID&sortOrder={if $sortField == 'userID' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.user.username{/lang}</a></th>
					<th class="columnText columnTitle{if $sortField == 'title'} active {@$sortOrder}{/if}"><a href="{link controller='PilloryWarnings'}pageNo={@$pageNo}&sortField=title&sortOrder={if $sortField == 'title' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.global.title{/lang}</a></th>
					<th class="columnText columnReason{if $sortField == 'reason'} active {@$sortOrder}{/if}"><a href="{link controller='PilloryWarnings'}pageNo={@$pageNo}&sortField=reason&sortOrder={if $sortField == 'reason' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.infraction.warning.reason{/lang}</a></th>
					<th class="columnText columnPoints{if $sortField == 'points'} active {@$sortOrder}{/if}"><a href="{link controller='PilloryWarnings'}pageNo={@$pageNo}&sortField=points&sortOrder={if $sortField == 'points' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.infraction.warning.points{/lang}</a></th>
					<th colspan="2" class="columnText columnJudge{if $sortField == 'judgeID'} active {@$sortOrder}{/if}"><a href="{link controller='PilloryWarnings'}pageNo={@$pageNo}&sortField=judgeID&sortOrder={if $sortField == 'judgeID' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.infraction.warning.judge{/lang}</a></th>
					<th class="columnText columnTime{if $sortField == 'time'} active {@$sortOrder}{/if}"><a href="{link controller='PilloryWarnings'}pageNo={@$pageNo}&sortField=time&sortOrder={if $sortField == 'time' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.pillory.time{/lang}</a></th>
					<th class="columnText columnExpires{if $sortField == 'expires'} active {@$sortOrder}{/if}"><a href="{link controller='PilloryWarnings'}pageNo={@$pageNo}&sortField=expires&sortOrder={if $sortField == 'expires' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{/link}">{lang}wcf.infraction.warning.expires{/lang}</a></th>
					{event name='columnHeads'}
				</tr>
			</thead>
			
			<tbody>
				{foreach from=$objects item=warning}
					<tr class="userWarning">
						<td class="columnIcon columnAvatar">
							{if $userProfiles[$warning->userID]->getAvatar()}
								<div>
									<p class="framed">{@$userProfiles[$warning->userID]->getAvatar()->getImageTag(32)}</p>
								</div>
							{/if}
						</td>
						<td class="columnText columnUsername">
							<h3>
								<a href="{link controller='User' object=$warning->getUser()}{/link}">{$warning->getUser()->username}</a>
							</h3>
						</td>
						<td class="columnText columnTitle">{lang}{$warning->title}{/lang}</td>
						<td class="columnText columnReason">{@$warning->reason|htmlspecialchars|nl2br}</td>
						<td class="columnText columnPoints">{#$warning->points}</td>
						<td class="columnIcon columnAvatar">
							{if $userProfiles[$warning->judgeID]->getAvatar()}
								<div>
									<p class="framed">{@$userProfiles[$warning->judgeID]->getAvatar()->getImageTag(32)}</p>
								</div>
							{/if}
						</td>
						<td class="columnText columnUsername">
							<h3>
								{if $warning->judgeID != 0}<a href="{link controller='User' object=$warning->getJudge()}{/link}">{$warning->getJudge()->username}</a>{else}<em>{lang}wcf.pillory.warnings.judge.unknown{/lang}</em>{/if}
							</h3>
						</td>
						<td class="columnText columnTime">{@$warning->time|time}</td>
						<td class="columnText columnExpires">{if $warning->expires != 0}{@$warning->expires|plainTime}{else}{lang}wcf.infraction.warning.expires.never.short{/lang}{/if}</td>
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