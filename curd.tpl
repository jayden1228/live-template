package model

import (
	gdb "gitlab.com/makeblock-go/mysql"
)

type $NAME$ struct {
	Id        int64   `gorm:"primary_key,column:id" json:"id"`
	CreatedAt int64   `gorm:"column:created_at" json:"created_at"`
	UpdatedAt int64   `gorm:"column:updated_at" json:"updated_at"`
}


var $NAME$Default $NAME$

func (c *$NAME$) TableName() string {
	return "$TableName$"
}

// Create is a function to create a single record to table
func (c *$NAME$) Create() (id int64, err error) {
	db := gdb.GetDB().Create(c)
	if err = db.Error; err != nil {
		return -1, err
	}
	return c.Id, nil
}

// DeleteById is a function to delete a single record from table
func (c *$NAME$) DeleteById(id int64) error {
	return gdb.GetDB().Table(c.TableName()).Delete($NAME${}, "id = ?", id).Error
}

// Update is a function to update record with specific field with data map to table
func (c *$NAME$) Update(id int, data map[string]interface{}) (rowsAffected int64, err error) {
	db := gdb.GetDB().Table(c.TableName()).Where("id = ?", id).Update(data)
	return db.RowsAffected, db.Error
}

// Save is a function to update record with all field with struct to table 
func (c *$NAME$) Save() (rowsAffected int64, err error) {
	db := gdb.GetDB().Save(c)
	return db.RowsAffected, db.Error
}

// GetById is a function to get a single record from the table
func (c *$NAME$) GetById(id int64) (*$NAME$, error) {
	var result $NAME$
	if err := gdb.GetDB().First(&result, id).Error; err != nil {
		return nil, err
	}
	return &result, nil
}



// GetList is a function to get a slice of record(s) from table
// params - page     - page requested (defaults to 0)
// params - pageSize - number of records in a page  (defaults to 20)
// params - order    - db sort order column
func (c *$NAME$) GetList(page, pageSize int64, order string) (results []*$NAME$, totalRows int, err error) {

	resultOrm := gdb.GetDB().Model(&$NAME${})
	resultOrm.Count(&totalRows)

	if page > 0 {
		offset := (page - 1) * pageSize
		resultOrm = resultOrm.Offset(offset).Limit(pageSize)
	} else {
		resultOrm = resultOrm.Limit(pageSize)
	}

	if order != "" {
		resultOrm = resultOrm.Order(order)
	}

	if err = resultOrm.Find(&results).Error; err != nil {
		return nil, -1, err
	}

	return results, totalRows, nil
}




