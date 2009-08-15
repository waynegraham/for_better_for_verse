<?php get_header(); ?>

<?php if (have_posts()) : while (have_posts()) : the_post(); ?>

<?php
	if(in_category('3')) :
		include (TEMPLATEPATH . '/loop_poem.php');
	else :
		include (TEMPLATEPATH . '/loop.php');
	endif;
?>

<?php endwhile; else: ?>

<div id="main" class="clearfloat">
<div class="wrapper">

<div id="content">
		<p>Select a poem to begin.</p>

<?php endif; ?>

</div><!--/content-->

<?php get_sidebar(); ?>

<?php get_footer(); ?>
