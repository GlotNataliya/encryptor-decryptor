class Encryptor
  
  # Шифровальщик
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    characters.zip(rotated_characters).to_h 
  end

  def encrypt(string, rotation)
    letter = string.split('')
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
    letter.map { |letter| cipher_for_rotation[letter] }.join
  end

  # Расшифровщик
  def decrypt(string, rotation)
    letter = string.split('')
    cipher_for_rotation = cipher(rotation).invert
    cipher_for_rotation[letter]
    letter.map { |letter| cipher_for_rotation[letter] }.join
  end

  # Шифровальщик файла 
  def encrypt_file(filename, rotation)
    if File.exist?(filename)
      file = File.open(filename, 'r') { |f| f.read }
      file_encrypt = encrypt(file, rotation)
      newfile = 'secret.txt.encrypted'
      filename.gsub(filename, newfile)
      File.open(newfile, 'w') { |f| f.write(file_encrypt) }
    else
      puts 'Файл не найден'
    end

   # Расшифровщик файла      
    def decrypt_file(filename, rotation)
      file = File.open(filename, 'r') { |f| f.read }
      file_decrypt = decrypt(file, rotation )
      newfile = 'secret.txt.decrypted'
      filename.gsub(filename, newfile)
      File.open(newfile, 'w') { |f| f.write(file_decrypt) }
    end
  end
end

e = Encryptor.new
puts e.encrypt_file('secret.txt', 11)
puts e.decrypt_file('secret.txt.encrypted', 11)
