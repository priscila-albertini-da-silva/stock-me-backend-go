package domain

import "gorm.io/gorm"

type StorageLocation struct {
	gorm.Model
	Name string `gorm:"size:255;not null"`
}
