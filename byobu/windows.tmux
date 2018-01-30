new-session -t 0 ;
rename-window GHE/ghe-migrate.log ;
split-window -c '/' -t 0 '/ghe-startup.sh' ;
split-window -c '/' -t 1 '/ghe-migrate-logs.sh' ;
select-pane -U ;
new-window -n gh-pages  su - gh-pages;
new-window -n gh-backups  su - gh-backup;
split-window ;
split-window ;
select-layout tiled ;
select-pane -t 0
