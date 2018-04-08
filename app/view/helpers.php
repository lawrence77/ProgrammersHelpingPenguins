<?php

function formatEvent($event) {

  switch($event->type) {
    case 'add_campaign':
		$creator = User::loadById($event->creator_id);
		$campaign = Campaign::loadById($event->item_1_id);
		$name = $campaign->name;

		$str = '<strong>'.$creator->username.'</strong> added the campaign <strong>'.$name.'</strong>. <small>('.time2str($event->date_created).')</small>';
		break;
	case 'delete_campaing':
		$creator = User::loadById($event->creator_id);
		$campaign = Campaign::loadById($event->item_1_id);
		$name = $campaign->name;

		$str = '<strong>'.$creator->username.'</strong> deleted the campaign <strong>'.$name.'</strong>. <small>('.time2str($event->date_created).')</small>';
		break;
	case 'edit_campaign':
		$creator = User::loadById($event->creator_id);
		$campaign = Campaign::loadById($event->item_1_id);
		$name = $campaign->name;

		$str = '<strong>'.$creator->username.'</strong> changed the following data in the campaign <strong>'.$name.'</strong>.
				<strong>'.$event->data_1.'</strong> to <strong>'.$event->data_2.'</strong><small>('.time2str($event->date_created).')</small>';
		break;
	case 'add_crew':
	
		$creator = User::loadById($event->creator_id);
		$crew = Crew::loadById($event->item_1_id);
		$name = $crew->provisionalWing;
		$str = '<strong>'.$creator->username.'</strong> added the crew <strong>'.$name.'</strong>. <small>('.time2str($event->date_created).')</small>';
		break;


    case 'add_friend':
      $str = 'add friend';
      break;

    default:
      $str = 'Invalid event type.';
      break;
  }

  return $str;

}


// source: https://stackoverflow.com/a/2690541
function time2str($ts)
{
    if(!ctype_digit($ts))
        $ts = strtotime($ts);

    $diff = time() - $ts;
    if($diff == 0)
        return 'now';
    elseif($diff > 0)
    {
        $day_diff = floor($diff / 86400);
        if($day_diff == 0)
        {
            if($diff < 60) return 'just now';
            if($diff < 120) return '1 minute ago';
            if($diff < 3600) return floor($diff / 60) . ' minutes ago';
            if($diff < 7200) return '1 hour ago';
            if($diff < 86400) return floor($diff / 3600) . ' hours ago';
        }
        if($day_diff == 1) return 'Yesterday';
        if($day_diff < 7) return $day_diff . ' days ago';
        if($day_diff < 31) return ceil($day_diff / 7) . ' weeks ago';
        if($day_diff < 60) return 'last month';
        return date('F Y', $ts);
    }
    else
    {
        $diff = abs($diff);
        $day_diff = floor($diff / 86400);
        if($day_diff == 0)
        {
            if($diff < 120) return 'in a minute';
            if($diff < 3600) return 'in ' . floor($diff / 60) . ' minutes';
            if($diff < 7200) return 'in an hour';
            if($diff < 86400) return 'in ' . floor($diff / 3600) . ' hours';
        }
        if($day_diff == 1) return 'Tomorrow';
        if($day_diff < 4) return date('l', $ts);
        if($day_diff < 7 + (7 - date('w'))) return 'next week';
        if(ceil($day_diff / 7) < 4) return 'in ' . ceil($day_diff / 7) . ' weeks';
        if(date('n', $ts) == date('n') + 1) return 'next month';
        return date('F Y', $ts);
    }
}
