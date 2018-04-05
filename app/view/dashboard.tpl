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
<?php foreach($fes as $fe): ?>
  <li><?= formatEvent($fe) ?></li>
<?php endforeach; ?>
</ul>
<?php endif; ?>

</div>
