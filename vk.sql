drop database if exists vk;
create database vk;
use vk;

drop table if exists users;
create table users(
	id serial primary key, -- PRIMARYPRIMARYbigint unsigned not null auto_increment unique
    firstname varchar(50),
    lastname varchar(50),
    email varchar(200) unique,
    phone bigint,
    index user_index_phone(phone),
    index user_firstname_lastname_index(firstname, lastname)
);

drop table if exists `profile`;
create table `profile`(
	user_id serial primary key,
    gender char(1),
    birthday date,
    photo_id bigint unsigned null,
    created_at datetime default now(),
    hometown varchar(100),
    foreign key (user_id) references users(id)
);

drop table if exists messages;
create table messages(
	id serial primary key,
    from_user_id bigint unsigned not null,
    to_user_id bigint unsigned not null,
    body text,
    created_at datetime default now(),
    index messages_from_user_id(from_user_id),
    index messages_to_user_id(to_user_id),
    foreign key (from_user_id) references users(id),
    foreign key (to_user_id) references users(id)
);

drop table if exists friend_requests;
create table friend_requests(
	initiator_user_id bigint unsigned not null,
    target_user_id bigint unsigned not null,
    `status` enum('requested', 'approved', 'unfriended', 'declined'),
    requested_at datetime default now(),
    confirmed_at datetime,
    
    primary key (initiator_user_id, target_user_id),
    index (initiator_user_id),
    index (target_user_id),
    foreign key (initiator_user_id) references users(id),
    foreign key (target_user_id) references users(id)
);

drop table if exists likes;
create table likes(
	like_from_user_id bigint unsigned not null,
    like_to_user_id bigint unsigned not null,
    like_given_at datetime default now(),
    
    primary key (like_from_user_id, like_to_user_id),
    index (like_from_user_id),
    index (like_to_user_id),
    foreign key (like_from_user_id) references users(id),
    foreign key (like_to_user_id) references users(id)
);
