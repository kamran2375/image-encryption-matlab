function [dec_img] = decrypt(enc_img)
dec_img = dec2bin(enc_img);
dec_img = dec_img(1:end, 8);
img_size = find(dec_img == '0', 2);
r = bin2dec(reshape(dec_img(img_size(2):img_size(2)+img_size(1)-1), 1, []));
c = bin2dec(reshape(dec_img(img_size(2)+img_size(1):img_size(2)+img_size(2)-2), 1, []));
dec_img = dec_img(img_size(2)*2-1:img_size(2)*2-2+r*c*3*8);
dec_img = reshape(dec_img, [], 8);
dec_img = reshape(uint8(bin2dec(dec_img)), [r, c, 3]);
end
