new-session -t 0 ;
rename-window GHE/ghe-migrate.log ;
split-window -c '/' -t 0 'ghe-startup.sh' ;
split-window -c '/' -t 1 'ghe-migrate-logs.sh' ;
select-pane -U ;
new-window -n gh-pages  sudo -u gh-pages jekyll-startup.sh ;
split-window -t 1 sudo -u gh-pages gollum-startup.sh ;
split-window -t 1 su - gh-pages ;
select-layout tiled ;
new-window -n ghe-backup  su - gh-backup ;
new-window -t 3 ghe-btop.sh ;
rename-window btop|logs-tail ;
split-window -t 3 'ghe-logs-tail.sh' ;
select-pane -t 0 
