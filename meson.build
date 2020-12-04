project('com.github.donadigo.eddy', 'vala', 'c')

gnome = import('gnome')
i18n = import('i18n')

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
  '-include', 'config.h'
]

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')
add_project_arguments('-DI_KNOW_THE_PACKAGEKIT_GLIB2_API_IS_SUBJECT_TO_CHANGE', language : 'c')

posix_dep = meson.get_compiler('vala').find_library('posix')

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/AppSettings.vala',
    'src/Constants.vala',
    'src/DetailedView.vala',
    'src/FolderLoader.vala',
    'src/MainWindow.vala',
    'src/MimeTypeHelper.vala',
    'src/Package.vala',
    'src/PackageListView.vala',
    'src/PackageRow.vala',
    'src/TransactionResult.vala',
    'src/LogManager.vala',
    'src/PackageUri.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        dependency('packagekit-glib2'),
        dependency('zeitgeist-2.0'),
        posix_dep,
        meson.get_compiler('c').find_library('m', required : false)
    ],
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson/post_install.py')