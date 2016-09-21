var path = require('path');
var gulp = require('gulp');
var plugins = require('gulp-load-plugins')();
var livereload = require('gulp-livereload');


var source = './src';
var destination = './dist';


gulp.task('copyXML', function() {
  return gulp.src(source + '/*.xml')
  .pipe(gulp.dest(destination))
  .pipe(plugins.xmlValidator())
  .pipe(livereload());
});

gulp.task('copyDTD', function() {
  return gulp.src(source + '/*.dtd')
  .pipe(gulp.dest(destination))
  .pipe(livereload());
});

gulp.task('copyCSS', function() {
  return gulp.src(source + '/*.css')
  .pipe(gulp.dest(destination))
  .pipe(livereload());
});

gulp.task('watch', function () {
  livereload.listen();
  gulp.watch(source + '/*.css', ['copyCSS']);
  gulp.watch(source + '/*.xml', ['copyXML']);
  gulp.watch(source + '/*.xml', ['copyDTD']);
});


gulp.task('build', ['copyCSS', 'copyXML', 'copyDTD']);
gulp.task('default', ['build']);
