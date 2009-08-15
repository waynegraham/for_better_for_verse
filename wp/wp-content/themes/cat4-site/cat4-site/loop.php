<?php $poem_author = get_post_meta($post->ID, 'Author', TRUE); ?>

<?php if (is_single()) : ?>
<div id="main" class="clearfloat">
<div class="wrapper">


<div id="content">

	<h2><?php the_title(); ?></h2>
	
	<div class="entry">
	<?php the_content(); ?>
	</div>

<?php
elseif (is_tag()) :
	if (in_category('3')) :
		include (TEMPLATEPATH . '/loop_archive.php');
	endif;
else :
	include (TEMPLATEPATH . '/loop_archive.php');

endif;
?>