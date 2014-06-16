CREATE TABLE person (
	id INT NOT NULL AUTO_INCREMENT,
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	PRIMARY KEY (id)
);

insert into person (first_name, last_name) values ('John', 'Doe');
