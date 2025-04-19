const { createClient } = require('@supabase/supabase-js');

exports.handler = async function(event, context) {
    try {
        // Initialize Supabase client
        const supabase = createClient(
            process.env.SUPABASE_URL,
            process.env.SUPABASE_ANON_KEY
        );

        // Test database connection by querying a simple table
        const { data, error } = await supabase
            .from('profiles')
            .select('id')
            .limit(1);

        if (error) {
            throw new Error(`Database connection failed: ${error.message}`);
        }

        return {
            statusCode: 200,
            body: JSON.stringify({
                success: true,
                message: 'Database connection successful',
                data: data
            })
        };
    } catch (error) {
        return {
            statusCode: 500,
            body: JSON.stringify({
                success: false,
                error: error.message
            })
        };
    }
}; 