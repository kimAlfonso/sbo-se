<?php
  session_start();
  require 'inc/db.inc.php';
  $evId = $_GET['id'];
  $sql = "SELECT * FROM sbo.events WHERE event_id = $evId;";
  $result = mysqli_query($conn, $sql);
  $resultCheck = mysqli_num_rows($result);

  if ($resultCheck > 0) {
    while ($row = mysqli_fetch_assoc($result)) {
      $title = $row['title'];
      $dateCr = $row['create_date'];
      $dateSt = $row['start_date'];
      $dateEnd = $row['end_date'];
      $desc = $row['description'];
    }
  } else if(empty($resultCheck)) {
    echo 'No results found.<br>';
  }

  if (isset($_SESSION['logged_in']) != TRUE) {
    header("Location: login.php?error=invader");
    exit();
  }

 ?>

<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name=viewport content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <link rel="stylesheet" href="src/css/master.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  </head>
  <body>
    <div class="main-wrapper">
      <div class="sidenav">
        <?php include 'sidenav.php'; ?>
      </div>

      <div class="content-wrapper">
        <h2>Event Detail</h2>
        <form class="" action="inc/edit.inc.php" method="post">
          <ul>
            <input type="text" name="id" value="<?php echo $evId;?>" readonly>
            <li>
              <label for="">Title</label>
              <input type="text" name="title" value="<?php echo $title; ?>" required >
            </li>
            <li>
              <label for="">Date Created</label>
              <input type="text" name="create" value="<?php echo $dateCr; ?>" readonly >
            </li>
            <li>
              <label for="">Start Date</label>
              <input type="text" name="start" value="<?php echo $dateSt; ?>">
            </li>
            <li>
              <label for="">End Date</label>
              <input type="text" name="end" value="<?php echo $dateEnd; ?>">
            </li>
            <li>
              <label for="">Description</label>
              <textarea name="event-desc" rows="8" cols="80" required >
                <?php
                  echo $desc;
                ?>
              </textarea>
            </li>

            <li>
              <button type="submit" name="edit-event">Save Changes</button>
            </li>
          </ul>
        </form>
        <hr>
        <h2>Attendance</h2>
        <!-- add new attendance button-->
        <button onclick="document.getElementById('id01').style.display='block'" class="float-right">Add Attendance</button>

        <!-- attendance table -->
        <table id="listofevents" class="display">
          <thead>
            <th>Attendance ID</th>
            <th>Name</th>
            <th>Date</th>
            <th>Category</th>
            <th>Sign In</th>
            <th>Sign out</th>
          </thead>
          <tbody>
            <?php
              require 'inc/db.inc.php';
              $sql = "SELECT sa.att_id, concat(s.last_name, ', ', s.first_name) as name, a.date, a.type, sa.sign_in, sa.sign_out FROM sbo.student_attendance sa
	               join student s on sa.student_id = s.student_id
                 join events e on sa.event_id = e.event_id
                 join attendance a on sa.att_id = a.attendance_id
              where sa.event_id = $evId;";
              $result = mysqli_query($conn, $sql);
              $resultCheck = mysqli_num_rows($result);

              if ($resultCheck > 0) {
                while ($row = mysqli_fetch_assoc($result)) {
                  echo '<tr>';
                  echo '<td>' .$row['att_id']. '</td>';
                  echo '<td>' .$row['name']. '</td>';
                  echo '<td>' .$row['date']. '</td>';
                  echo '<td>' .$row['type']. '</td>';
                  echo '<td>' .$row['sign_in']. '</td>';
                  echo '<td>' .$row['sign_out']. '</td>';
                  echo '</tr>';
                }
              }
            ?>
          </tbody>
        </table> <!-- attendance table -->

        <div id="id01" class="w3-modal">
          <div class="w3-modal-content w3-card-4">
            <header class="w3-container w3-teal">
              <span onclick="document.getElementById('id01').style.display='none'"
              class="w3-button w3-display-topright">&times;</span>
              <h2>New Student Registration</h2>
            </header>
            <div class="w3-container">
              <form class="w3-container" action="inc/insert.inc.php" method="post">
                <p>
                  <label>Student ID</label></p>
                  <input type="text" class="w3-input" name="studID" required>

                </p>
                <p>
                  <label>Last Name</label></p>
                  <input type="text" class="w3-input" name="lname" required>
                </p>
                <p>
                  <label>First Name</label></p>
                  <input type="text" class="w3-input" name="fname" required>
                </p>
                <p>
                  <label>Middle Name</label></p>
                  <input type="text" class="w3-input" name="mname" required>
                </p>
                <p>
                  <label>Address</label></p>
                  <input type="text" class="w3-input" name="address" required>
                </p>
                <p>
                  <label>Contact Number</label></p>
                  <input type="text" class="w3-input" name="num" required>
                </p>
                <p>
                  <button class="w3-btn" type="submit" name="saveStud">Save</button>
                </p>
              </form>
            </div>
            <footer class="w3-container w3-teal">

            </footer>
          </div>
        </div> <!-- end modal -->

      </div>
    </div> <!-- end main wrapper -->


   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
   <script>
     $(document).ready( function () {
       $('#listofevents').DataTable();
     } );
   </script>



  </body>
</html>
