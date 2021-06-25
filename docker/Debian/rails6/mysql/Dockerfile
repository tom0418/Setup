# 2021.04.29 時点での MySQL5.7 系最新安定板
FROM mysql:5.7.34

# ローカルの my.cnf を作業ディレクトリにコピー
ADD ./my.cnf /etc/mysql/conf.d/my.cnf

# MySQL 起動
CMD ["mysqld"]
