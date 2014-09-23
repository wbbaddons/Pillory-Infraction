<?php
namespace wcf\page;

use wcf\page\AbstractPilloryPage;
use wcf\data\user\UserProfile; 
use wcf\system\WCF;

/**
 * Represents a list of suspensions.
 * 
 * @author	Joshua Rüsweg
 * @copyright	2014 Joshua Rüsweg
 * @license	Creative Commons Attribution-ShareAlike 4.0 <https://creativecommons.org/licenses/by-sa/4.0/legalcode>
 * @package	be.bastelstu.josh.pillory.infraction
 * @subpackage	wcf.page
 */
class PillorySuspensionsPage extends AbstractPilloryPage {

	/**
	 * @see \wcf\page\SortablePage::$defaultSortField
	 */
	public $defaultSortField = 'time';
	
	/**
	 * @see \wcf\page\SortablePage::$validSortFields
	 */
	public $validSortFields = array('userID', 'suspensionID', 'expires', 'time');

	/**
	 * @see	\wcf\page\AbstractPage::$neededPermissions
	 */
	public $neededPermissions = array('user.pillory.canSeeSuspensions');
	
	/**
	 * @see	\wcf\page\MultipleLinkPage::$objectListClassName
	 */
	public $objectListClassName = 'wcf\data\user\infraction\suspension\UserInfractionSuspensionList';
	
	/**
	 * @see \wcf\page\AbstractPilloryPage::$type
	 */
	public $type = 'suspensions'; 
	
	/**
	 * all needed userProfiles
	 */
	public $userProfiles = array();
	
	/**
	 * @see	\wcf\page\MultipleLinkPage::initObjectList()
	 */
	protected function initObjectList() {
		parent::initObjectList();
		
		$this->objectList->getConditionBuilder()->add("user_infraction_suspension.revoked <> 1");
	}
	
	/**
	 * @see	\wcf\page\MultipleLinkPage::readObjects()
	 */
	protected function readObjects() {
		parent::readObjects(); 
		
		foreach ($this->objectList->getObjects() as $suspension) {
			if (!isset($this->userProfiles[$suspension->userID])) {
				$this->userProfiles[$suspension->userID] = new UserProfile($suspension->getUser()); 
			}
		}
	}
	
	/**
	 * @see	\wcf\page\IPage::assignVariables()
	 */
	public function assignVariables() {
		parent::assignVariables(); 
		
		WCF::getTPL()->assign(array(
		    'userProfiles' => $this->userProfiles
		));
	}
}