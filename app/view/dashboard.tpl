<?php include_once 'view/helpers.php' ?>

<div id="left">
  <h2>Dashboard</h2>
  <p>Welcome, <?= $_SESSION['username'] ?>.</p>

</div>

<div id="right">

<h3>Recent Activity</h3>

<?php if(empty($fes)): ?>
  <p>No events yet.</p>
<?php else: ?>
<ul>
<?php $following = $user->following;?>
<?php foreach($fes as $fe): ?>
<?php if($fe->creator_id == $user->id or in_array($fe->creator_id,$following)): ?>
  <li><?= formatEvent($fe) ?></li>
  <?php endif; ?>
<?php endforeach; ?>
</ul>
<?php endif; ?>

</div>
