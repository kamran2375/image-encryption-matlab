function varargout = main(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function select_secret_img_btn(hObject, eventdata, handles)
[file, path] = uigetfile({'*.png'; '*.jpg'}, 'Select The Image');
if ~isequal(file, 0)
    set(handles.secret_img_text, 'String', fullfile(path, file));
    imshow(imread(fullfile(path, file)), 'Parent', handles.axes1);
end

function select_template_img_btn(hObject, eventdata, handles)
[file, path] = uigetfile({'*.png'; '*.jpg'}, 'Select The Image');
if ~isequal(file, 0)
    set(handles.template_img_text, 'String', fullfile(path, file));
    imshow(imread(fullfile(path, file)), 'Parent', handles.axes2);
end

function encrypt_btn(hObject, eventdata, handles)
if ~isequal(get(handles.secret_img_text, 'String'), 'No Image Selected!')...
        && ~isequal(get(handles.template_img_text, 'String'), 'No Image Selected!')
    secret_img = imread(get(handles.secret_img_text, 'String'));
    template_img = imread(get(handles.template_img_text, 'String'));
    encrypted_img = encrypt(secret_img, template_img);
    imwrite(encrypted_img, strcat(datestr(now,'yyyymmddHHMMSSFFF'), '_encrypted.png'));
    figure;
    subplot(1, 3, 1);imshow(secret_img);title('Secret Image');
    subplot(1, 3, 2);imshow(template_img);title('Template Image');
    subplot(1, 3, 3);imshow(encrypted_img);title('Encrypted Image');
end

function select_encrypted_img_btn(hObject, eventdata, handles)
[file, path] = uigetfile('*.png', 'Select The Image');
if ~isequal(file, 0)
    set(handles.encrypted_img_text, 'String', fullfile(path, file));
    imshow(imread(fullfile(path, file)), 'Parent', handles.axes3);
end

function decrypt_btn(hObject, eventdata, handles)
if ~isequal(get(handles.encrypted_img_text, 'String'), 'No Image Selected!')
    encrypted_img = imread(get(handles.encrypted_img_text, 'String'));
    decrypted_img = decrypt(encrypted_img);
    imwrite(decrypted_img, strcat(datestr(now,'yyyymmddHHMMSSFFF'), '_decrypted.png'));
    figure;
    subplot(1, 2, 1);imshow(encrypted_img);title('Encrypted Image');
    subplot(1, 2, 2);imshow(decrypted_img);title('Decrypted Image');
end
