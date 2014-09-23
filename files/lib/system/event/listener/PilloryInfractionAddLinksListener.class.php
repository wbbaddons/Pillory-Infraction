<?php
namespace wcf\system\event\listener;

use wcf\system\event\IEventListener;
use wcf\system\WCF; 

/**
 * add links for the pillory
 * 
 * @author	Joshua Rüsweg
 * @copyright	2014 Joshua Rüsweg
 * @license	Creative Commons Attribution-ShareAlike 4.0 <https://creativecommons.org/licenses/by-sa/4.0/legalcode>
 * @package	be.bastelstu.josh.pillory.infraction
 */
class PilloryInfractionAddLinksListener implements IEventListener {

	/**
	 * @see	wcf\system\event\IEventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName) {
		if (WCF::getSession()->getPermission('user.pillory.canSeeWarnings')) $eventObj->aviablePages[] = 'PilloryWarnings';
		if (WCF::getSession()->getPermission('user.pillory.canSeeSuspensions')) $eventObj->aviablePages[] = 'PillorySuspensions';
	}

}
