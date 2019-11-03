class User < ApplicationRecord
	validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Merci d'inserer un email valide" }
	validates :first_name, presence: true, word: true
	validates :last_name, word: true, on: :update
	validates :age, format: {with: /[0-9]{2}/, message: "l'age doit etre ecrit avec 2 chiffres"}, on: :update
	validates :description, text:true, on: :update
	validates :city_id, text: true, on: :update
	validates :password, presence: true, length: {minimum: 6} 
		
	has_secure_password
		
	belongs_to :city
	has_many :gosssips
	has_many :comments
	has_many :gosssips, through: :comments
	has_many :likes, dependent: :destroy
	has_many :gosssips, through: :likes

end
