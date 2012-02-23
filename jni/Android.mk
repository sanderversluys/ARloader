#==============================================================================
#            Copyright (c) 2010-2011 QUALCOMM Incorporated.
#            All Rights Reserved.
#            Qualcomm Confidential and Proprietary
#==============================================================================


# An Android.mk file must begin with the definition of the LOCAL_PATH
# variable. It is used to locate source files in the development tree. Here
# the macro function 'my-dir', provided by the build system, is used to return
# the path of the current directory.

LOCAL_PATH := $(call my-dir)

# The following section is used for copying the libQCAR.so prebuilt library
# into the appropriate folder (libs/armeabi and libs/armeabi-v7a respectively)
# and setting the include path for library-specific header files

include $(CLEAR_VARS)
LOCAL_MODULE := QCAR-prebuilt
LOCAL_SRC_FILES = ../../../Development/libs/qcar/qcar-android-1-0-6/build/lib/$(TARGET_ARCH_ABI)/libQCAR.so
LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)/../../../Development/libs/qcar/qcar-android-1-0-6/build/include
include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE:= libobj
LOCAL_MODULE_FILENAME := libobj
LOCAL_C_INCLUDES := $(LOCAL_PATH)/libobj
LOCAL_CFLAGS    := -Werror -Wall -O4
LOCAL_SRC_FILES := libobj/Mesh.cpp libobj/MeshUtil.cpp libobj/zip_fgets.cpp
LOCAL_LDLIBS    := -lGLESv1_CM -ldl -llog -lz 

include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_CFLAGS := 

LOCAL_MODULE    := libpng
LOCAL_SRC_FILES :=\
	libpng/png.c \
	libpng/pngerror.c \
	libpng/pngget.c \
	libpng/pngmem.c \
	libpng/pngpread.c \
	libpng/pngread.c \
	libpng/pngrio.c \
	libpng/pngrtran.c \
	libpng/pngrutil.c \
	libpng/pngset.c \
	libpng/pngtrans.c \
	libpng/pngwio.c \
	libpng/pngwrite.c \
	libpng/pngwtran.c \
	libpng/pngwutil.c 
	
LOCAL_LDLIBS := -lz

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE    := libzip
LOCAL_SRC_FILES :=\
	libzip/zip_add.c \
	libzip/zip_add_dir.c \
	libzip/zip_close.c \
	libzip/zip_delete.c \
	libzip/zip_dirent.c \
	libzip/zip_entry_free.c \
	libzip/zip_entry_new.c \
	libzip/zip_err_str.c \
	libzip/zip_error.c \
	libzip/zip_error_clear.c \
	libzip/zip_error_get.c \
	libzip/zip_error_get_sys_type.c \
	libzip/zip_error_strerror.c \
	libzip/zip_error_to_str.c \
	libzip/zip_fclose.c \
	libzip/zip_file_error_clear.c \
	libzip/zip_file_error_get.c \
	libzip/zip_file_get_offset.c \
	libzip/zip_file_strerror.c \
	libzip/zip_filerange_crc.c \
	libzip/zip_fopen.c \
	libzip/zip_fopen_index.c \
	libzip/zip_fread.c \
	libzip/zip_free.c \
	libzip/zip_get_archive_comment.c \
	libzip/zip_get_archive_flag.c \
	libzip/zip_get_file_comment.c \
	libzip/zip_get_num_files.c \
	libzip/zip_get_name.c \
	libzip/zip_memdup.c \
	libzip/zip_name_locate.c \
	libzip/zip_new.c \
	libzip/zip_open.c \
	libzip/zip_rename.c \
	libzip/zip_replace.c \
	libzip/zip_set_archive_comment.c \
	libzip/zip_set_archive_flag.c \
	libzip/zip_set_file_comment.c \
	libzip/zip_source_buffer.c \
	libzip/zip_source_file.c \
	libzip/zip_source_filep.c \
	libzip/zip_source_free.c \
	libzip/zip_source_function.c \
	libzip/zip_source_zip.c \
	libzip/zip_set_name.c \
	libzip/zip_stat.c \
	libzip/zip_stat_index.c \
	libzip/zip_stat_init.c \
	libzip/zip_strerror.c \
	libzip/zip_unchange.c \
	libzip/zip_unchange_all.c \
	libzip/zip_unchange_archive.c \
	libzip/zip_unchange_data.c

LOCAL_LDLIBS := -lz

#include $(BUILD_SHARED_LIBRARY)
include $(BUILD_STATIC_LIBRARY)

#-----------------------------------------------------------------------------

# The CLEAR_VARS variable is provided by the build system and points to a
# special GNU Makefile that will clear many LOCAL_XXX variables for you
# (e.g. LOCAL_MODULE, LOCAL_SRC_FILES, LOCAL_STATIC_LIBRARIES, etc...),
# with the exception of LOCAL_PATH. This is needed because all build
# control files are parsed in a single GNU Make execution context where
# all variables are global.

include $(CLEAR_VARS)

# The LOCAL_MODULE variable must be defined to identify each module you
# describe in your Android.mk. The name must be *unique* and not contain
# any spaces. Note that the build system will automatically add proper
# prefix and suffix to the corresponding generated file. In other words,
# a shared library module named 'foo' will generate 'libfoo.so'.

LOCAL_MODULE := ARLoader

# The TARGET_PLATFORM defines the targetted Android Platform API level

TARGET_PLATFORM := android-5

# This variable determines the OpenGL ES API version to use:
# If set to true, OpenGL ES 1.1 is used, otherwise OpenGL ES 2.0.

USE_OPENGL_ES_1_1 := false

# Set OpenGL ES version-specific settings.

ifeq ($(USE_OPENGL_ES_1_1), true)
    OPENGLES_LIB  := -lGLESv1_CM
	OPENGLES_DEF  := -DUSE_OPENGL_ES_1_1
else
    OPENGLES_LIB  := -lGLESv2
	OPENGLES_DEF  := -DUSE_OPENGL_ES_2_0
endif

# An optional set of compiler flags that will be passed when building
# C ***AND*** C++ source files.
#
# NOTE: flag "-Wno-write-strings" removes warning about deprecated conversion
#       from string constant to ‘char*’

LOCAL_CFLAGS := -Wno-write-strings $(OPENGLES_DEF) -Wall -O4

# The list of additional linker flags to be used when building your
# module. This is useful to pass the name of specific system libraries
# with the "-l" prefix.

LOCAL_LDLIBS := \
    -llog $(OPENGLES_LIB) -lz -ldl
    
# The list of shared libraries *modules* this module depends on at runtime.
# This is necessary at link time and to embed the corresponding information
# in the generated file. We reference the prebuilt library defined earlier 
# in this makefile.
     
LOCAL_SHARED_LIBRARIES := QCAR-prebuilt

# The LOCAL_SRC_FILES variables must contain a list of C and/or C++ source
# files that will be built and assembled into a module. Note that you should
# not list header and included files here, because the build system will
# compute dependencies automatically for you; just list the source files
# that will be passed directly to a compiler, and you should be good.

LOCAL_SRC_FILES := ARLoader.cpp SampleUtils.cpp Texture.cpp

LOCAL_STATIC_LIBRARIES := libobj libzip libpng

# By default, ARM target binaries will be generated in 'thumb' mode, where
# each instruction are 16-bit wide. You can define this variable to 'arm'
# if you want to force the generation of the module's object files in
# 'arm' (32-bit instructions) mode

LOCAL_ARM_MODE := arm

# The BUILD_SHARED_LIBRARY is a variable provided by the build system that
# points to a GNU Makefile script that is in charge of collecting all the
# information you defined in LOCAL_XXX variables since the latest
# 'include $(CLEAR_VARS)' and determine what to build, and how to do it
# exactly. There is also BUILD_STATIC_LIBRARY to generate a static library.

include $(BUILD_SHARED_LIBRARY)
