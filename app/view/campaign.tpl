<div id="main-content">
  <a href="<?= $BASE_URL ?>/campaigns">Back to Campaign list </a><br />

  <h1>Campaign: <?php echo $campaign['name']; ?></h1>

  <table id="campaign" class="left">
	<tr>
		<td>Name:</td>
		<td> <?php echo $campaign['name']; ?> </td>
	</tr>
	<tr>
		<td>Date:</td>
		<td> <?php echo $campaign['date']; ?> </td>
    </tr>
	<tr>
		<td>Description:</td>
		<td> <?php echo $campaign['description']; ?> </td>
    </tr>
  </table>

</div>