class Encryptor

  # Шифровальщик
  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    (characters.zip(rotated_characters)).to_h 
  end

  def encrypt(string, rotation)
    letter = string.split("")
      
    res = []
    letter.collect do |letter|
    encrypted_letter = encrypt_letter(letter, rotation)
    res << encrypted_letter
  end
   
    res.join
  end

  def encrypt_letter(letter,rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  # Расшифровщик
  def decipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = characters.rotate(rotation)
    (characters.zip(rotated_characters)).to_h.invert  
  end

  def decrypt(string, rotation)
    letter = string.split("")
      
    res = []
    letter.collect do |letter|
    encrypted_letter = deencrypt_letter(letter, rotation)
    res << encrypted_letter
    end
   
    res.join
  end

  def deencrypt_letter(letter,rotation)
    cipher_for_rotation = decipher(rotation)
    cipher_for_rotation[letter]
  end

  # Шифровальщик файла 
  def encrypt_file(filename, rotation)

    if File.exist?(filename)
      file = File.open(filename, 'r'){ |file| file.read }
      file_encrypt = file.encrypt(filename, rotation)
      newfile = "secret.txt.encrypted"
      newfile = filename.gsub(filename, newfile)
      newfile = File.open(newfile, "w"){ |file| file.write(file_encrypt) }
    else
      puts "Файл не найден"
    end

   #  Расшифровщик файла      
    def decrypt_file(filename, rotation)
      file = File.open(filename, 'r'){ |file| file.read }
      file_decrypt = file.decrypt(file, rotation)
      newfile = "secret.txt.decrypted"
      newfile = filename.gsub(filename, newfile)
      newfile = File.open(newfile, "w"){ |file| file.write(file_decrypt) }
    end
     
  end
end

e = Encryptor.new
e.encrypt_file("secret.txt", 11)
e.decrypt_file("secret.txt.encrypted", 11)
