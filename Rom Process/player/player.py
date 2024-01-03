from PIL import Image

def png_to_12bitrgb_coe(png_path, coe_path):
    # 读取PNG图像
    img = Image.open(png_path)
    
    # 确保图像是RGB模式
    img = img.convert('RGBA')
    
    # 获取图像的宽度和高度
    width, height = img.size
    
    # 创建COE文件
    with open(coe_path, 'w') as coe_file:
        # 写入COE文件头部
        coe_file.write("memory_initialization_radix=2;\n")
        coe_file.write("memory_initialization_vector=\n")
        
        # 遍历图像的每个像素
        for y in range(height):
            for x in range(width):
                # 获取像素的RGB值
                r, g, b, a = img.getpixel((x, y))
                
                # 将RGB值转换为12位格式
                if a == 0:
                    rgb_12bit = int('110011001100', 2)
                else:
                    rgb_12bit = ((r & 0xF0) << 4) | ((g & 0xF0)) | ((b & 0xF0) >> 4)
                
                # 将12位RGB值写入COE文件
                coe_file.write(f"{rgb_12bit:012b}")
                
                # 判断是否是最后一个像素，如果是则写入分号，否则写入逗号
                if x == width - 1 and y == height - 1:
                    coe_file.write(";\n")
                else:
                    coe_file.write(",\n")

# 用法示例
png_to_12bitrgb_coe("player.png", "player.coe")
