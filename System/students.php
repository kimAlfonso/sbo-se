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
        <?php
          include 'sidenav.php';
        ?>
      </div>
      <div class="content-wrapper">
        <h1>Students List</h1>
        <!--w3 modal -->
        <button onclick="document.getElementById('id01').style.display='block'" class="w3-button w3-black float-right">Register New Student</button>
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

        <!-- dataTables -->
        <table id="event" class="display">
          <thead>
            <tr>
              <th>Student ID</th>
              <th>Name</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th>Student ID</th>
              <th>Actions</th>
            </tr>
          </tfoot>
          <tbody>
            <?php
              require 'inc/db.inc.php';
              $sql = "SELECT student_id, concat(last_name, ', ' , first_name) as name FROM sbo.student;";
              $result = mysqli_query($conn, $sql);
              $resultCheck = mysqli_num_rows($result);

              if ($resultCheck > 0) {
                while ($row = mysqli_fetch_assoc($result)) {
                  //$dateEvent = date('M d Y', strtotime($row['start_date']));
                  echo '<tr>';
                  echo '<td><a href="#">'. $row['student_id'].'</a></td>';
                  echo '<td>'. $row['name'] .'</td>';
                  echo '</tr>';
                }
              }
            ?>
          </tbody>
        </table>

      </div> <!-- end content wrapper -->
    </div> <!-- End main wrapper -->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
    <script>
      $(document).ready( function () {
        $('#event').DataTable();
      } );

    </script>
  </body>
</html>
