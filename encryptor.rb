class Encryptor
  
  # Шифровальщик
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    characters.zip(rotated_characters).to_h 
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def encrypt(string, rotation)
    letter = string.split('')
    res = []
    letter.collect do |letter|
    encrypted_letter = encrypt_letter(letter, rotation)
    res << encrypted_letter
    end
    res.join
  end

  # Расшифровщик
  def decipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    characters.zip(rotated_characters).to_h.invert  
  end

  def decrypt_letter(letter, rotation)
    cipher_for_rotation = decipher(rotation)
    cipher_for_rotation[letter]
  end

  def decrypt(string, rotation)
    letter = string.split('')
    res = []
    letter.collect do |letter|
    encrypted_letter = decrypt_letter(letter, rotation)
    res << encrypted_letter
    end
    res.join
  end

  # Шифровальщик файла 
  def encrypt_file(filename, rotation)
    
    if File.exist?(filename)
      file = File.open(filename, 'r') { |f| f.read }
      letter = file.split('')
      res = []
      letter.collect do |letter|
      encrypted_letter = encrypt_letter(letter, rotation)
      res << encrypted_letter
      end
      file_encrypt = res.join
      newfile = 'secret.txt.encrypted'
      filename.gsub(filename, newfile)
      File.open(newfile, 'w') { |f| f.write(file_encrypt) }
    else
      puts 'Файл не найден'
    end

   # Расшифровщик файла      
    def decrypt_file(filename, rotation)
      file = File.open(filename, 'r') { |f| f.read }
      letter = file.split('')
      res = []
      letter.collect do |letter|
      encrypted_letter = decrypt_letter(letter, rotation)
      res << encrypted_letter
      end
      file_decrypt = res.join
      newfile = 'secret.txt.decrypted'
      filename.gsub(filename, newfile)
      File.open(newfile, 'w') { |f| f.write(file_decrypt) }
    end
  end
end

e = Encryptor.new
puts e.encrypt_file('secret.txt', 11)
puts e.decrypt_file('secret.txt.encrypted', 11)
