name "webserverrole"
description "This is a web server role"
run_list "role[base]", "recipe[apache]"
