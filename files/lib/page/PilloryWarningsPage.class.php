<?php
namespace wcf\page;

use wcf\page\AbstractPilloryPage;
use wcf\data\user\UserProfile; 
use wcf\system\WCF;

/**
 * Represents a list of warnings.
 * 
 * @author	Joshua Rüsweg
 * @copyright	2014 Joshua Rüsweg
 * @license	Creative Commons Attribution-ShareAlike 4.0 <https://creativecommons.org/licenses/by-sa/4.0/legalcode>
 * @package	be.bastelstu.josh.pillory.infraction
 * @subpackage	wcf.page
 */
class PilloryWarningsPage extends AbstractPilloryPage {

	/**
	 * @see \wcf\page\SortablePage::$defaultSortField
	 */
	public $defaultSortField = 'time';
	
	/**
	 * @see \wcf\page\SortablePage::$validSortFields
	 */
	public $validSortFields = array('userID', 'reason', 'title', 'points', 'expires', 'judgeID', 'time');

	/**
	 * @see	\wcf\page\AbstractPage::$neededPermissions
	 */
	public $neededPermissions = array('user.pillory.canSeeWarnings');
	
	/**
	 * @see	\wcf\page\MultipleLinkPage::$objectListClassName
	 */
	public $objectListClassName = 'wcf\data\user\infraction\warning\UserInfractionWarningList';
	
	/**
	 * @see \wcf\page\AbstractPilloryPage::$type
	 */
	public $type = 'warnings'; 
	
	/**
	 * all needed userProfiles
	 */
	public $userProfiles = array();
	
	/**
	 * @see	\wcf\page\MultipleLinkPage::initObjectList()
	 */
	protected function initObjectList() {
		parent::initObjectList();
		
		$this->objectList->getConditionBuilder()->add("user_infraction_warning.revoked <> 1");
	}
	
	/**
	 * @see	\wcf\page\MultipleLinkPage::readObjects()
	 */
	protected function readObjects() {
		parent::readObjects(); 
		
		foreach ($this->objectList->getObjects() as $warning) {
			if (!isset($this->userProfiles[$warning->userID])) {
				$this->userProfiles[$warning->userID] = new UserProfile($warning->getUser()); 
			}
			
			if (!isset($this->userProfiles[$warning->judgeID])) {
				$this->userProfiles[$warning->judgeID] = new UserProfile($warning->getJudge()); 
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