<div class="container users">
    <div class="container">
        <div class="text-center">
            <strong style="font-size:36px;">Users</strong>
        </div>
    </div>
    <hr />
    <table class="table table-striped">
        <thead>
            <tr>
                <th>
                    <p class="text-center" style="font-size:24px;">Username</p>
                </th>
                <th>
                    <p class="text-center" style="font-size:24px;">Action</p>
                </th>
            </tr>
        </thead>
        <tbody>
            <?php
                //var_dump($_SESSION);
                $id = $_SESSION['user_id'];
                if(is_array($id))
                $id = $id['id'];
                $user = User::loadById($id);

                $users = User::getUsers();
                foreach($users as $u)
                {
                    echo "<tr>";
                        echo "<td>";
                            echo "<a href='".BASE_URL."/users/view/".$u->id."'>";
                            echo $u->firstName . " " . $u->lastName . "&nbsp;&nbsp;";
                            echo "</a>";
                        echo "</td>";
                        echo "<td class='text-center'>";
                            if($id && $u->id != $id && !in_array($u->id, $user->following)) {
                                echo "<button id='user_b_" . $u->id . "' class='btn btn-primary' onclick='follow(" . $id . ", ". $u->id .")'>Follow</button>";
                            }
                            else if($id && $u->id != $id && in_array($u->id, $user->following)) {
                                echo "<button id='user_b_" . $u->id . "' class='btn btn-danger' onclick='unfollow(" . $id . ", ". $u->id .")'>Unfollow</button>";
                            }
                            else {
                                echo "<p class='text-warning'>None</p>";
                            }
                        echo "</td>";
                    echo "</tr>";
                }
            ?>
        </tbody>
    </table>
</div>
