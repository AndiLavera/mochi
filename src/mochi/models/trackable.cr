module Mochi::Models
  # Track information about your user sign in. It tracks the following columns:
  #
  # * sign_in_count      - Increased every time a sign in is made (by form, openid, oauth)
  # * current_sign_in_at - A timestamp updated when the user signs in
  # * last_sign_in_at    - Holds the timestamp of the previous sign in
  # * current_sign_in_ip - The remote ip updated when the user sign in
  # * last_sign_in_ip    - Holds the remote ip of the previous sign in
  #
  module Trackable
    def update_tracked_fields!(request)
      # We have to check if the user is already persisted before running
      # TODO: self.save(skip_validation: true)
      # Need to open PR with Granite
      return if new_record?

      update_tracked_fields(request)
      self.save # (skip_validation: true)
    end

    def update_tracked_fields(request)
      old_current, new_current = self.current_sign_in_at, Time.utc
      self.last_sign_in_at = old_current || new_current
      self.current_sign_in_at = new_current

      old_current, new_current = self.current_sign_in_ip, extract_ip_from(request)
      self.last_sign_in_ip = old_current || new_current
      self.current_sign_in_ip = new_current

      self.sign_in_count ||= 0
      self.sign_in_count += 1
    end

    private def extract_ip_from(request)
      request.remote_address
    end
  end
end
