class Room < ActiveRecord::Base
	has_many :songs, dependent: :destroy

	# validates :name, presence: true, uniqueness: true

	def current_song
		songs[song_counter]
	end

	def next_song
		songs[song_counter + 1]
	end

	def increment_counter
		self.song_counter += 1
		self.save
	end

	def send_text(number)
		@account_sid = ENV['TWILIO_SID']
		@auth_token = ENV['TWILIO_TOKEN']
		@recipient = "+1#{number}"
		@link = "10.10.44.67:3000/rooms/#{self.id}"
		
		# set up a client
		@client = Twilio::REST::Client.new(@account_sid, @auth_token)
		@client.account.messages.create(
		  from: '+15874001631',
		  to: @recipient,
		  body: @link
		)
	end

end



