name "dev"
description "this is the dev environment"
cookbook "apache", "= 0.1.5"
override_attributes({
	"author" => {
		"name" => "this is author attribute from dev.rb env"
	}
})
