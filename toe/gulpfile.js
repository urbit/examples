var gulp = require('gulp');
var rollup = require('gulp-better-rollup');
var sucrase = require('@sucrase/gulp-plugin');
var minify = require('gulp-minify');

var resolve = require('rollup-plugin-node-resolve');
var commonjs = require('rollup-plugin-commonjs');
var rootImport = require('rollup-plugin-root-import');
var globals = require('rollup-plugin-node-globals');


var urbitrc = require('./.urbitrc');

gulp.task('tile-jsx-transform', function(cb) {
  return gulp.src('./src/tile/**/*.js')
    .pipe(sucrase({
      transforms: ['jsx']
    }))
    .pipe(gulp.dest('dist'));
});


gulp.task('tile-js-imports', function(cb) {
  return gulp.src('dist/tile.js')
    .pipe(rollup({
      plugins: [
        commonjs({
          namedExports: {
            'node_modules/react/index.js': [ 'Component' ],
          }
        }),
        rootImport({
          root: `${__dirname}/dist/js`,
          useEntry: 'prepend',
          extensions: '.js'
        }),
        globals(),
        resolve()
      ]
    }, 'umd'))
    .on('error', function(e){
      console.log(e);
      cb();
    })
    .pipe(gulp.dest('./src/urbit/app/toe/js/'))
    .on('end', cb);
});

gulp.task('tile-js-minify', function () {
  return gulp.src('./src/urbit/app/toe/js/tile.js')
    .pipe(minify())
    .pipe(gulp.dest('./src/urbit/app/toe/js/'));
});

gulp.task('urbit-copy', function () {
  let ret = gulp.src('./src/urbit/**/*');

  urbitrc.URBIT_PIERS.forEach(function(pier) {
    ret = ret.pipe(gulp.dest(pier));
  });

  return ret;
});

gulp.task('tile-js-bundle-dev', gulp.series('tile-jsx-transform', 'tile-js-imports'));
gulp.task('tile-js-bundle-prod',
  gulp.series('tile-jsx-transform', 'tile-js-imports', 'tile-js-minify')
);
gulp.task('bundle-prod', gulp.series('tile-js-bundle-prod', 'urbit-copy'));
gulp.task('default', gulp.series('tile-js-bundle-dev', 'urbit-copy'));
gulp.task('watch', gulp.series('default', function() {
  gulp.watch('./src/tile/**/*.js', gulp.parallel('tile-js-bundle-dev'));
  gulp.watch('./src/urbit/**/*', gulp.parallel('urbit-copy'));
}));
