#before use this. access to your root folder -> cd /etc -> sudo vim sudoers -> comment line  "Defaults requiretty" 

#parameters 
# $1: shortcut name server
# $2: branch git




ssh -T host /bin/bash << EOF
	ssh -T $1
	cd hurricane_v1
	git branch
	git stash
	git fetch origin $2
	git checkout $2 
	git stash apply
	sudo service unicorn_stgapi stop
	echo "Stopped server"
	sleep 3
	sudo service unicorn_stgapi start
	echo "Server is running"

	# cat tmp/pids/sidekiq.pid | xargs kill
	# bundle exec sidekiq -d -L log/sidekiq.log -C config/sidekiq.yml -e staging
EOF


