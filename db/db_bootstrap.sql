CREATE DATABASE captionista_db;
GRANT ALL PRIVILEGES ON captionista_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE captionista_db;

CREATE TABLE endUsers
(
    username          VARCHAR(20) PRIMARY KEY,
    instagramHandle   VARCHAR(255),
    pointsFromReplies INT DEFAULT 0 CHECK (pointsFromReplies >= 0) NOT NULL,
    joinDate          DATE                                         NOT NULL
);

CREATE TABLE creators
(
    username             VARCHAR(20) PRIMARY KEY,
    emailAddress         VARCHAR(255) NOT NULL,
    joinDate             DATE         NOT NULL,
    firstName            VARCHAR(20)  NOT NULL,
    lastName             VARCHAR(20)  NOT NULL,
    password             VARCHAR(255) NOT NULL,
    biography            VARCHAR(255),
    highlightedCaptionID INT
);

CREATE TABLE moderators
(
    moderatorID INT PRIMARY KEY AUTO_INCREMENT,
    dateJoined  DATE NOT NULL
);

CREATE TABLE captions
(
    captionID   INT PRIMARY KEY AUTO_INCREMENT,
    datePosted  DATE          NOT NULL,
    points      INT DEFAULT 0 NOT NULL,
    captionText VARCHAR(255)  NOT NULL,
    numSaves    INT DEFAULT 0 NOT NULL,
    creator     VARCHAR(20)   NOT NULL,
    FOREIGN KEY (creator)
        REFERENCES creators (username)
);

CREATE TABLE images
(
    imageID    INT PRIMARY KEY AUTO_INCREMENT,
    datePosted DATE NOT NULL,
    userID     VARCHAR(20),
    captionID  INT,
    FOREIGN KEY (userID)
        REFERENCES endUsers (username),
    FOREIGN KEY (captionID)
        REFERENCES captions (captionID)
);

CREATE TABLE creatorFollow
(
    username        VARCHAR(20),
    creatorUsername VARCHAR(20),
    FOREIGN KEY (username) REFERENCES endUsers (username),
    FOREIGN KEY (creatorUsername) REFERENCES creators (username)
);

CREATE TABLE tag
(
    tagID   INT PRIMARY KEY AUTO_INCREMENT,
    tagName VARCHAR(20) NOT NULL
);

CREATE TABLE tagCategory
(
    categoryID   INT PRIMARY KEY AUTO_INCREMENT,
    categoryName VARCHAR(20)   NOT NULL,
    numTags      INT DEFAULT 0 NOT NULL
);

CREATE TABLE captionTag
(
    captionID INT,
    tagID     INT,
    FOREIGN KEY (captionID) REFERENCES captions (captionID),
    FOREIGN KEY (tagID) REFERENCES tag (tagID),
    PRIMARY KEY (captionID, tagID)
);

CREATE TABLE replies
(
    replyID    INT PRIMARY KEY AUTO_INCREMENT,
    datePosted DATE          NOT NULL,
    replyText  VARCHAR(255)  NOT NULL,
    points     INT DEFAULT 0 NOT NULL,
    username   VARCHAR(20),
    captionID  INT,
    FOREIGN KEY (username) REFERENCES endUsers (username),
    FOREIGN KEY (captionID) REFERENCES captions (captionID)
);

CREATE TABLE replyFlag
(
    moderatorID INT,
    replyID     INT,
    timeFlagged DATE         NOT NULL,
    reason      VARCHAR(255) NOT NULL,
    FOREIGN KEY (moderatorID) REFERENCES moderators (moderatorID),
    FOREIGN KEY (replyID) REFERENCES replies (replyID),
    PRIMARY KEY (moderatorID, replyID)
);

CREATE TABLE tagOnImage
(
    tagID   INT,
    imageID INT,
    FOREIGN KEY (tagID) REFERENCES tag (tagID),
    FOREIGN KEY (imageID) REFERENCES images (imageID),
    PRIMARY KEY (tagID, imageID)
);

CREATE TABLE tagFollow
(
    userFollowing VARCHAR(20),
    tagFollowing  INT,
    FOREIGN KEY (userFollowing) REFERENCES endUsers (username),
    FOREIGN KEY (tagFollowing) REFERENCES tag (tagID),
    PRIMARY KEY (userFollowing, tagFollowing)
);

CREATE TABLE tagHasCategory
(
    tagID      INT,
    categoryID INT,
    FOREIGN KEY (tagID) REFERENCES tag (tagID),
    FOREIGN KEY (categoryID) REFERENCES tagCategory (categoryID),
    PRIMARY KEY (tagID, categoryID)
);

ALTER TABLE creators
    ADD CONSTRAINT FOREIGN KEY (highlightedCaptionID) REFERENCES captions (captionID);


INSERT INTO endUsers(username, instagramHandle, pointsFromReplies, joinDate)
VALUES ('emackaig0', 'ethrelkeld0', 48, '2022-01-11')
     , ('tnono1', 'fcraft1', 92, '2022-01-26')
     , ('sangric2', 'apumphreys2', 82, '2022-06-30')
     , ('fondra3', 'asthill3', 31, '2022-01-03')
     , ('vgoggan4', 'lbertelsen4', 36, '2022-09-22')
     , ('qraisher5', NULL, 1, '2022-09-23')
     , ('pmorhall6', 'rcalbrathe6', 16, '2021-12-29')
     , ('speckham7', 'trobard7', 33, '2022-02-19')
     , ('dbernard8', NULL, 77, '2022-08-05')
     , ('dmagrannell9', NULL, 26, '2022-08-28')
     , ('swaltona', 'baudena', 56, '2022-07-14')
     , ('abickstethb', 'bcoarserb', 62, '2022-07-23')
     , ('tyuryichevc', 'bsilvermanc', 14, '2022-10-23')
     , ('trosenwaldd', 'gedgerd', 67, '2022-06-25')
     , ('amityushkine', NULL, 80, '2022-06-01')
     , ('gboolsenf', 'ahabishawf', 44, '2022-01-28')
     , ('lcodmang', 'mstuchberyg', 43, '2022-11-12')
     , ('ddarnbroughh', 'folyhaneh', 23, '2022-11-20')
     , ('abridgensi', 'randreaseni', 36, '2022-01-28')
     , ('censtenj', NULL, 62, '2022-03-11');

INSERT INTO creators(username, emailAddress, joinDate, firstName, lastName, password, biography, highlightedCaptionID)
VALUES ('hwanden0', 'hwanden0@freewebs.com', '2022-07-04', 'Hermia', 'Wanden', 'UDGzTR5MUC',
        'Maecenas ut massa quis augue luctus tincidunt.', NULL)
     , ('wstarkey1', 'wstarkey1@gmpg.org', '2022-10-07', 'Willy', 'Starkey', 'RQYtCFUBzA',
        'Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis. Fusce posuere felis sed lacus.',
        NULL)
     , ('dmcclure2', 'dmcclure2@goo.gl', '2022-09-11', 'Demeter', 'McClure', 'd6QOGS2',
        'Duis bibendum. Morbi non quam nec dui luctus rutrum.', NULL)
     , ('oyouthed3', 'oyouthed3@ibm.com', '2022-07-06', 'Omar', 'Youthed', 'KNAkIw5ZK99',
        'Vivamus vel nulla eget eros elementum pellentesque. Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla.',
        NULL)
     , ('ciggo4', 'ciggo4@nytimes.com', '2022-07-28', 'Celle', 'Iggo', 'vq5OpC2l',
        'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', NULL)
     , ('mpetteford5', 'mpetteford5@imageshack.us', '2022-11-06', 'Maxim', 'Petteford', '45qHvT0EpXBs',
        'Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh. Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est.',
        NULL)
     , ('rbruty6', 'rbruty6@creativecommons.org', '2022-07-12', 'Redd', 'Bruty', '8GdCqb',
        'Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', NULL)
     , ('lbarnicott7', 'lbarnicott7@adobe.com', '2022-08-23', 'Laural', 'Barnicott', 'pPANEZC4',
        'Nulla nisl. Nunc nisl.', NULL)
     , ('rsnelson8', 'rsnelson8@google.com', '2022-06-08', 'Reider', 'Snelson', 'X9DFqcCIWE',
        'Quisque id justo sit amet sapien dignissim vestibulum.', NULL)
     , ('kmaccracken9', 'kmaccracken9@cdc.gov', '2022-06-01', 'Kearney', 'MacCracken', 'KDXPyxHULQn', 'Ut tellus.',
        NULL);

INSERT INTO moderators(moderatorID, dateJoined)
VALUES (1, '2021-11-25')
     , (2, '2022-08-29')
     , (3, '2022-06-26')
     , (4, '2022-04-29')
     , (5, '2022-08-07')
     , (6, '2022-07-03')
     , (7, '2022-07-03')
     , (8, '2022-09-29')
     , (9, '2022-04-01')
     , (10, '2022-05-21')
     , (11, '2022-11-12')
     , (12, '2022-11-11')
     , (13, '2021-12-03')
     , (14, '2022-04-20')
     , (15, '2022-04-30')
     , (16, '2022-11-05')
     , (17, '2022-04-21')
     , (18, '2021-12-29')
     , (19, '2022-05-05')
     , (20, '2022-07-25');

INSERT INTO captions(captionID, datePosted, points, captionText, numSaves, creator)
VALUES (1, '2022-10-01', 70, 'Maecenas pulvinar lobortis est.', 53, 'kmaccracken9')
     , (2, '2021-12-24', 35,
        'Cras in purus eu magna vulputate luctus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',
        69, 'rbruty6')
     , (3, '2022-05-07', 88, 'Nullam varius.', 16, 'hwanden0')
     , (4, '2022-09-11', 57, 'Quisque ut erat. Curabitur gravida nisi at nibh.', 12, 'kmaccracken9')
     , (5, '2022-06-27', 95, 'Aenean lectus. Pellentesque eget nunc.', 5, 'lbarnicott7')
     , (6, '2022-07-13', 51, 'In hac habitasse platea dictumst. Etiam faucibus cursus urna.', 93, 'hwanden0')
     , (7, '2022-08-10', 40,
        'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante.',
        6, 'wstarkey1')
     , (8, '2022-11-14', 28, 'Vivamus in felis eu sapien cursus vestibulum. Proin eu mi.', 53, 'dmcclure2')
     , (9, '2022-10-14', 69, 'Ut tellus.', 92, 'dmcclure2')
     , (10, '2022-05-01', 34,
        'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa.', 50,
        'oyouthed3')
     , (11, '2022-03-28', 58, 'Duis aliquam convallis nunc.', 75, 'mpetteford5')
     , (12, '2022-03-21', 69,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio.',
        96, 'kmaccracken9')
     , (13, '2022-06-25', 30,
        'Morbi vel lectus in quam fringilla rhoncus. Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',
        52, 'lbarnicott7')
     , (14, '2022-09-23', 67, 'Morbi non quam nec dui luctus rutrum. Nulla tellus.', 44, 'wstarkey1')
     , (15, '2021-11-26', 83, 'Vivamus tortor.', 70, 'rbruty6')
     , (16, '2022-09-09', 49, 'In quis justo. Maecenas rhoncus aliquam lacus.', 8, 'rbruty6')
     , (17, '2022-09-30', 14,
        'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.',
        57, 'hwanden0')
     , (18, '2022-04-21', 3, 'Nulla ac enim.', 0, 'oyouthed3')
     , (19, '2022-03-20', 10, 'Donec posuere metus vitae ipsum.', 87, 'dmcclure2')
     , (20, '2022-08-09', 74, 'Ut at dolor quis odio consequat varius.', 24, 'oyouthed3');

INSERT INTO images(imageID, datePosted, userID, captionID)
VALUES (1, '2021-12-24', 'qraisher5', 11)
     , (2, '2022-03-22', 'tnono1', 17)
     , (3, '2022-04-21', 'tyuryichevc', 10)
     , (4, '2022-07-16', 'trosenwaldd', 12)
     , (5, '2022-01-22', 'gboolsenf', 10)
     , (6, '2022-06-27', 'fondra3', 10)
     , (7, '2021-12-31', 'pmorhall6', 5)
     , (8, '2022-08-06', 'dbernard8', 19)
     , (9, '2022-02-17', 'swaltona', 19)
     , (10, '2022-07-30', 'speckham7', 12);

INSERT INTO creatorFollow(username, creatorUsername)
VALUES ('emackaig0', 'dmcclure2')
     , ('gboolsenf', 'rbruty6')
     , ('lcodmang', 'wstarkey1')
     , ('gboolsenf', 'wstarkey1')
     , ('lcodmang', 'oyouthed3')
     , ('qraisher5', 'wstarkey1')
     , ('fondra3', 'rsnelson8')
     , ('fondra3', 'mpetteford5')
     , ('sangric2', 'lbarnicott7')
     , ('qraisher5', 'ciggo4');

INSERT INTO tag(tagID, tagName)
VALUES ('1', 'turpis')
     , ('2', 'vel')
     , ('3', 'dolor')
     , ('4', 'arcu')
     , ('5', 'integer')
     , ('6', 'nulla')
     , ('7', 'in')
     , ('8', 'lectus')
     , ('9', 'vel')
     , ('10', 'turpis')
     , ('11', 'lectus')
     , ('12', 'vel')
     , ('13', 'orci')
     , ('14', 'et')
     , ('15', 'erat')
     , ('16', 'pharetra')
     , ('17', 'mauris')
     , ('18', 'habitasse')
     , ('19', 'amet')
     , ('20', 'maecenas');

INSERT INTO tagCategory(categoryID, categoryName, numTags)
VALUES (1, 'sed', 31)
     , (2, 'rutrum', 47)
     , (3, 'lectus', 16)
     , (4, 'risus', 64)
     , (5, 'parturient', 75)
     , (6, 'semper', 31)
     , (7, 'eros', 63)
     , (8, 'maecenas', 32)
     , (9, 'ac', 22)
     , (10, 'et', 30);

INSERT INTO captionTag(captionID, tagID)
VALUES (9, 4)
     , (12, 5)
     , (7, 13)
     , (14, 8)
     , (10, 15)
     , (12, 7)
     , (10, 6)
     , (1, 9)
     , (19, 19)
     , (10, 2);

INSERT INTO replies(replyID, datePosted, replyText, points, username, captionID)
VALUES (1, '2022-02-13',
        'Ut tellus. Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi. Cras non velit nec nisi vulputate nonummy.',
        88, 'vgoggan4', 12)
     , (2, '2022-11-05',
        'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit. Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.',
        88, 'amityushkine', 20)
     , (3, '2021-12-26',
        'Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet. Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo.',
        66, 'qraisher5', 20)
     , (4, '2022-01-11',
        'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum. Proin eu mi. Nulla ac enim.',
        8, 'amityushkine', 1)
     , (5, '2022-08-03', 'Morbi a ipsum. Integer a nibh.', 71, 'trosenwaldd', 11)
     , (6, '2022-04-03', 'Integer a nibh.', 28, 'ddarnbroughh', 9)
     , (7, '2022-06-06',
        'Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus. Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.',
        98, 'tnono1', 5)
     , (8, '2022-06-22', 'Nunc purus.', 83, 'dbernard8', 16)
     , (9, '2021-12-07', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo.', 1, 'censtenj', 15)
     , (10, '2021-12-06',
        'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et.',
        57, 'swaltona', 17);

INSERT INTO replyFlag(moderatorID, replyID, timeFlagged, reason)
VALUES (2, 5, '2021-12-23',
        'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in.')
     , (4, 5, '2022-07-14',
        'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci.')
     , (4, 4, '2022-10-13',
        'Duis at velit eu est congue elementum. In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo.')
     , (14, 9, '2022-03-26',
        'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst. Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem.')
     , (3, 1, '2022-11-21',
        'Mauris sit amet eros. Suspendisse accumsan tortor quis turpis. Sed ante. Vivamus tortor. Duis mattis egestas metus.');

INSERT INTO tagOnImage(tagID, imageID)
VALUES (17, 4)
     , (19, 10)
     , (2, 6)
     , (3, 8)
     , (4, 9)
     , (10, 10)
     , (3, 9)
     , (5, 10)
     , (1, 1)
     , (19, 4);

INSERT INTO tagFollow(userFollowing, tagFollowing)
VALUES ('fondra3', 8)
     , ('fondra3', 11)
     , ('speckham7', 19)
     , ('lcodmang', 7)
     , ('vgoggan4', 16)
     , ('ddarnbroughh', 14)
     , ('sangric2', 7)
     , ('pmorhall6', 15)
     , ('sangric2', 10)
     , ('vgoggan4', 13);

INSERT INTO tagHasCategory(tagID, categoryID)
VALUES (7, 8)
     , (8, 10)
     , (12, 7)
     , (1, 10)
     , (5, 7)
     , (20, 2)
     , (6, 4)
     , (7, 4)
     , (18, 5)
     , (6, 9);

