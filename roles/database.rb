name "dbrole"
description "mysql database role"
run_list "role[base]", "recipe[mysql]"
