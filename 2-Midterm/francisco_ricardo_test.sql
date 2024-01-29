--Q3
connect sys/sys as sysdba;
CREATE USER francisco_ricardo_test IDENTIFIED BY 123;
GRANT connect , resource, create view TO francisco_ricardo_test;
connect francisco_ricardo_test/123;
SPOOL C:\BD1\francisco_ricardo_test.txt

--a)create tables
CREATE TABLE supplier(suppid NUMBER, suppname VARCHAR2(50));
CREATE TABLE member(mid NUMBER, memname VARCHAR2(50));
CREATE TABLE video(vid NUMBER, title VARCHAR2(50), rating CHAR(1), suppid NUMBER);
CREATE TABLE rental(mid NUMBER, vid NUMBER, date_rented DATE);

--create PKs
ALTER TABLE supplier
ADD CONSTRAINT supplier_suppid_PK PRIMARY KEY (suppid); 
ALTER TABLE member
ADD CONSTRAINT member_mid_PK PRIMARY KEY (mid); 
ALTER TABLE video
ADD CONSTRAINT video_vid_PK PRIMARY KEY (vid); 
ALTER TABLE rental
ADD CONSTRAINT rental_mid_vid_PK PRIMARY KEY (mid,vid); 

--create FKs
ALTER TABLE video
ADD CONSTRAINT video_suppid_FK FOREIGN KEY (suppid)
REFERENCES supplier(suppid);
ALTER TABLE rental
ADD CONSTRAINT rental_mid_FK FOREIGN KEY (mid)
REFERENCES member(mid);
ALTER TABLE rental
ADD CONSTRAINT rental_vid_FK FOREIGN KEY (vid)
REFERENCES video(vid); 

--add/modify constraints NN
ALTER TABLE supplier
MODIFY(suppname CONSTRAINT supplier_suppname_NN NOT NULL);
ALTER TABLE video
MODIFY(title CONSTRAINT video_title_NN NOT NULL);
ALTER TABLE member
MODIFY(memname CONSTRAINT member_memname_NN NOT NULL);

--add column
ALTER TABLE member
ADD (gender CHAR(1));

--create CK
ALTER TABLE member
ADD CONSTRAINT member_gender_CK CHECK (gender in ('M','m','F','f'));

--create UK
ALTER TABLE video
ADD CONSTRAINT video_rating_UK UNIQUE (rating);


--Q4
--INSERT VALUES
INSERT INTO supplier(suppid, suppname)
VALUES (1,'SUP1');
INSERT INTO member(mid, memname)
VALUES (1,'MEM1');
INSERT INTO video(vid, title, rating, suppid)
VALUES (1,'VID1','A',1);
INSERT INTO rental(mid, vid, date_rented)
VALUES (1,1,SYSDATE);

--Q5
--CREATE SEQUENCES
CREATE SEQUENCE supplier_seq START WITH 2 INCREMENT BY 1;
CREATE SEQUENCE member_seq START WITH 2 INCREMENT BY 1;
CREATE SEQUENCE video_seq START WITH 2 INCREMENT BY 1;

--INSERT VALUES USING SEQUENCE
INSERT INTO supplier(suppid, suppname)
VALUES (supplier_seq.NEXTVAL,'SUP2');
INSERT INTO member(mid, memname)
VALUES (member_seq.NEXTVAL,'MEM2');
INSERT INTO video(vid, title, rating, suppid)
VALUES (video_seq.NEXTVAL,'VID2','B',supplier_seq.CURRVAL);
INSERT INTO rental(mid, vid, date_rented)
VALUES (member_seq.CURRVAL,video_seq.CURRVAL,SYSDATE);

--Q6
-- display MemName, video title, rating, suppName, date rented of all video rented by mid = 1

SELECT m.memname, v.title, r.date_rented, v.rating, s.suppname 
FROM member m, video v, rental r, supplier s
WHERE m.mid = r.mid
and v.vid = r.vid
and v.suppid = s.suppid
and m.mid = 1;

-- turn off spooling
spool off;