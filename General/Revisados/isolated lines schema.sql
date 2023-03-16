CREATE TABLE dbo.sites (
    site_code NVARCHAR(50) NOT NULL,
    is_enabled BIT DEFAULT(1) NOT NULL,
    CONSTRAINT PK_sites PRIMARY KEY(site_code)
);

CREATE TABLE dbo.parts (
    part_no NVARCHAR(50) NOT NULL,
    site_code NVARCHAR(50) NOT NULL,
    is_enabled BIT DEFAULT(1) NOT NULL,
    CONSTRAINT PK_parts PRIMARY KEY (part_no, site_code),
    CONSTRAINT FK_parts_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code)
);

CREATE TABLE dbo.points_of_use (
    point_of_use_no NVARCHAR(50) NOT NULL,
    comments NVARCHAR(MAX) NULL,
    active_container_no NVARCHAR(50) NULL,
    site_code NVARCHAR(50) NOT NULL,
    is_enabled BIT DEFAULT(1) NOT NULL,
    CONSTRAINT PK_points_of_use PRIMARY KEY (point_of_use_no, site_code),
    CONSTRAINT FK_points_of_use_parts FOREIGN KEY (active_container_no, site_code) REFERENCES dbo.parts(part_no, site_code),
    CONSTRAINT FK_points_of_use_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code)
);

CREATE TABLE dbo.containers (
    container_no NVARCHAR(50) NOT NULL,
    component_no NVARCHAR(50) NULL,
    site_code NVARCHAR(50) NOT NULL,
    is_enabled BIT DEFAULT(1) NOT NULL,
    CONSTRAINT PK_containers PRIMARY KEY (container_no, site_code),
    CONSTRAINT FK_containers_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code),
    CONSTRAINT FK_containers_parts FOREIGN KEY (component_no, site_code) REFERENCES dbo.parts(part_no, site_code),
);


CREATE TABLE dbo.product_lines (
    product_line_code NVARCHAR(50) NOT NULL,
    active_part_no NVARCHAR(50) NULL,
    site_code NVARCHAR(50) NOT NULL,
    is_enabled BIT DEFAULT(1) NOT NULL,
    CONSTRAINT PK_product_lines PRIMARY KEY (product_line_code, site_code),
    CONSTRAINT FK_product_lines_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code),
    CONSTRAINT FK_product_lines_parts FOREIGN KEY (active_part_no, site_code) REFERENCES dbo.parts(part_no, site_code),
);

CREATE TABLE dbo.product_lines_points_of_use (
    product_line_code NVARCHAR(50) NOT NULL,
    point_of_use_no NVARCHAR(50) NOT NULL,
    ordinal INT NOT NULL,
    site_code NVARCHAR(50) NOT NULL,
    is_enabled BIT DEFAULT(1) NOT NULL,
    CONSTRAINT PK_product_lines_points_of_use PRIMARY KEY (product_line_code, point_of_use_no, site_code),
    CONSTRAINT FK_product_lines_points_of_use_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code),
    CONSTRAINT FK_product_lines_points_of_use_points_of_use FOREIGN KEY (point_of_use_no, site_code) REFERENCES dbo.points_of_use(point_of_use_no, site_code),
    CONSTRAINT FK_product_lines_points_of_use_product_lines FOREIGN KEY (product_line_code, site_code) REFERENCES dbo.product_lines(product_line_code, site_code)
);

CREATE TABLE bom (
    part_no NVARCHAR(50) NOT NULL,
    component_no NVARCHAR(50) NOT NULL,
    cardinality INT DEFAULT(1) NOT NULL,
    site_code NVARCHAR(50) NOT NULL,
    is_enabled BIT DEFAULT(1) NOT NULL,
    CONSTRAINT PK_bom PRIMARY KEY (part_no, component_no, site_code),
    CONSTRAINT UX_bom UNIQUE (part_no, component_no, site_code),
    CONSTRAINT FK_bom_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code),
    CONSTRAINT FK_bom_parts_1 FOREIGN KEY (part_no, site_code) REFERENCES dbo.parts(part_no, site_code),
    CONSTRAINT FK_bom_parts_2 FOREIGN KEY (component_no, site_code) REFERENCES dbo.parts(part_no, site_code)
);

CREATE TABLE dbo.product_line_bom_point_of_use_setting (
    product_line_code NVARCHAR(50) NOT NULL,
    point_of_use_no NVARCHAR(50) NOT NULL,
    part_no NVARCHAR(50) NOT NULL,
    component_no NVARCHAR(50) NOT NULL,
    site_code NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_product_line_bom_point_of_use_setting PRIMARY KEY (product_line_code, point_of_use_no, part_no, component_no),
    CONSTRAINT FK_product_line_bom_point_of_use_setting_parts_1 FOREIGN KEY (part_no, site_code) REFERENCES dbo.parts(part_no, site_code),
    CONSTRAINT FK_product_line_bom_point_of_use_setting_parts_2 FOREIGN KEY (component_no, site_code) REFERENCES dbo.parts(part_no, site_code),
    CONSTRAINT FK_product_line_bom_point_of_use_setting_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code),
    CONSTRAINT FK_product_line_bom_point_of_use_setting_points_of_use FOREIGN KEY (point_of_use_no, site_code) REFERENCES dbo.points_of_use(point_of_use_no, site_code),
    CONSTRAINT FK_product_line_bom_point_of_use_setting_product_lines FOREIGN KEY (product_line_code, site_code) REFERENCES dbo.product_lines(product_line_code, site_code)
);

CREATE TABLE dbo.point_of_use_containers (
    point_of_use_no NVARCHAR(50) NOT NULL,
    container_no NVARCHAR(50) NOT NULL,
    site_code NVARCHAR(50) NOT NULL,
    time_stamp DATETIME DEFAULT(GETDATE()) NOT NULL,
    CONSTRAINT PK_point_of_use_containers PRIMARY KEY (container_no, point_of_use_no, site_code),
    CONSTRAINT FK_point_of_use_containers_sites FOREIGN KEY (site_code) REFERENCES dbo.sites(site_code),
    CONSTRAINT FK_point_of_use_containers_points_of_use FOREIGN KEY (point_of_use_no, site_code) REFERENCES dbo.points_of_use(point_of_use_no, site_code),
    CONSTRAINT FK_point_of_use_containers_containers FOREIGN KEY (container_no, site_code) REFERENCES dbo.containers(container_no, site_code)
);