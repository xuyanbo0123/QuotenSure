## list ##
heroku pg:backups --app <appname>

## backup ##
heroku pg:backups capture --app <appname>

## download ##
heroku pg:backups public-url b001 --app <appname>

[download the link and then rename it to <filename>]

## delete backup ##
heroku pg:backups delete b001 --app <appname> --confirm <appname>

## restore locally ##

[before restore makesure the backup and local is the same migration version]

[push heroku and do a db:migrate before dump is a good practice]

[otherwise rollback local to backup's migration version]

pg_restore --clean --no-acl --no-owner -h localhost -U user -d project_development <filename>