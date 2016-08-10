FactoryGirl.define do
  factory :bigbluebutton_recording do |r|
    r.association :server, :factory => :bigbluebutton_server
    r.association :room, :factory => :bigbluebutton_room
    r.association :meeting, :factory => :bigbluebutton_meeting
    r.meetingid { "meeting" + SecureRandom.hex(8) }
    r.sequence(:name) { |n| "Rec #{n}" }
    r.published true
    r.start_time { Time.now - rand(5).hours }
    r.end_time { Time.now + rand(5).hours }
    # TODO: should contain the meeting's start_time at the end
    r.sequence(:recordid) { |n| "rec#{n}-#{SecureRandom.uuid}-#{DateTime.now.to_i}" }
    r.size { rand((20*1024**2)..(500*1024**2)) } # size ranging from 20Mb to 500Mb
    r.available true
    r.description { Forgery(:lorem_ipsum).words(10) }

    after(:create) do |r|
      r.updated_at = r.updated_at.change(:usec => 0)
      r.created_at = r.created_at.change(:usec => 0)
      r.start_time = r.start_time.change(:usec => 0)
      r.end_time = r.end_time.change(:usec => 0)
    end
  end
end
