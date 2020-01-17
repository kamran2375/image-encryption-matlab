function [encrypted_img] = encrypt(secret_img, template_img)
r = dec2bin(size(secret_img, 1));
c = dec2bin(size(secret_img, 2));
img_size = strcat(pad('0', length(r)+1, 'left', '1'), pad('0', length(c)+1, 'left', '1'), r, c);
secret_img_bin = dec2bin(secret_img);
secret_img_bin = secret_img_bin(1:end);
template_img_bin = dec2bin(template_img);
template_img_bin(1:length(secret_img_bin)+length(img_size), 8) = strcat(img_size, secret_img_bin);
encrypted_img = reshape(uint8(bin2dec(template_img_bin)), size(template_img));
end
