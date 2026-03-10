CREATE TABLE IF NOT EXISTS auth(
    id UUID PRIMARY KEY DEFAULT uuidv7(),
    user_name TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
            
CREATE TABLE IF NOT EXISTS users(
    id UUID REFERENCES auth(id) ON DELETE CASCADE,
    user_name TEXT REFERENCES auth(user_name) ON DELETE CASCADE,
    name VARCHAR(20) NOT NULL,
    email TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'student',
    phone TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS admin(
    admin_id UUID REFERENCES users(id) PRIMARY KEY on DELETE CASCADE,
);

create table if not exists hostels(
    hostel_id UUID primary key default uuidv7(),
    hostel_name text not null,
    location text not null,
    capacity integer not null,
);

create table if not exists rooms(
    room_id UUID primary key default uuidv7(),
    hostel_name text not null,
    room_capacity integer not null,
    status text not null default 'available'
);

create table if not exists student(
    student_id uuid references users(id) primary key on delete cascade, 
    roll_no varchar(20) unique not null,
    hostel_name text not null,
    room_id uuid references rooms(id) on delete set null
);

create table if not exists maintenance_staff(
    staff_id UUID REFERENCES users(id) PRIMARY KEY on DELETE CASCADE, 
    designation TEXT NOT NULL
);

create table if not exists assets(
    asset_id uuid primary key default uuiv7(),
    name text not null,
    condition text not null,
    room_id uuid references rooms(id) on delete set null
);

create table if not exists complaint_images(
    image_id uuid primary key default uuidv7(),
    image blob not null
);

create table if not exists complaints(
    complaint_id uuid primary key default uuidv7(),
    student_id uuid references student(student_id) on delete set null, 
    title text not null,
    details text not null,
    image_id uuid references complaint_images(image_id) on delete set null,
    status text not null default 'pending',
    created_at timestamp with time zone default current_timestamp,
    updated_at timestamp with time zone default current_timestamp,
    assigned_staff_id uuid references maintenance_staff(staff_id) on delete set null
    rating integer default null
);

create table if not exist announcements(
    announcement_id uuid primary key default uuidv7(),
    admin_id uuid references admin(admin_id) on delete set null,
    title text not null,
    content text not null,
    type text not null,
    posted_date timestamp with time zone default current_timestamp,
);

create table if not exists mess_feedback(
    feedback_id uuid primary key default uuidv7(),
    student_id uuid references student(student_id) on delete set null,
    rating integer not null,
    comments text default null,
    created_at timestamp with time zone default current_timestamp
);