<?php include_once 'view/helpers.php' ?>

<div class="jumbotron well well-sm">
    <h1>Dashboard</h1>
    <div class="container text-left">
        <p>Welcome, <?= $_SESSION['username'] ?>.</p>
    </div>
</div>

<div class="panel panel-default">
    <div class="panel-heading">
        <h2>Recent Activity</h2>
    </div>
    <div class="panel-body" style="font-size:16px;">
        <?php if(empty($fes)): ?>
          <p>No events yet.</p>
        <?php else: ?>
        <ul>
        <?php $following = $user->following;?>
        <?php foreach($fes as $fe): ?>
        <?php if($fe->creator_id == $user->id or in_array($fe->creator_id,$following)): ?>
          <li style="padding:5px;"><?= formatEvent($fe) ?></li>
          <?php endif; ?>
        <?php endforeach; ?>
        </ul>
        <?php endif; ?>
    </div>
</div>
