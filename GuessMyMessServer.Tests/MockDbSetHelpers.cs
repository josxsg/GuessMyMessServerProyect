using Moq;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace GuessMyMessServer.Tests
{
    public static class MockDbSetExtensions
    {
        public static Mock<DbSet<T>> SetupData<T>(this Mock<DbSet<T>> mockSet, IQueryable<T> data) where T : class
        {
            mockSet.As<IDbAsyncEnumerable<T>>()
                .Setup(m => m.GetAsyncEnumerator())
                .Returns(new TestDbAsyncEnumerator<T>(data.GetEnumerator()));

            mockSet.As<IQueryable<T>>()
                .Setup(m => m.Provider)
                .Returns(new TestDbAsyncQueryProvider<T>(data.Provider));

            mockSet.As<IQueryable<T>>().Setup(m => m.Expression).Returns(data.Expression);
            mockSet.As<IQueryable<T>>().Setup(m => m.ElementType).Returns(data.ElementType);
            mockSet.As<IQueryable<T>>().Setup(m => m.GetEnumerator()).Returns(data.GetEnumerator());
            mockSet.Setup(m => m.AsNoTracking()).Returns(mockSet.Object);
            mockSet.Setup(m => m.Include(It.IsAny<string>())).Returns(mockSet.Object);
            return mockSet;
        }
    }

    internal class TestDbAsyncQueryProvider<TEntity> : IDbAsyncQueryProvider
    {
        private readonly IQueryProvider _inner;

        internal TestDbAsyncQueryProvider(IQueryProvider inner)
        {
            _inner = inner;
        }

        public IQueryable CreateQuery(Expression expression)
        {
            return new TestDbAsyncEnumerable<TEntity>(expression);
        }

        public IQueryable<TElement> CreateQuery<TElement>(Expression expression)
        {
            return new TestDbAsyncEnumerable<TElement>(expression);
        }

        public object Execute(Expression expression)
        {
            return _inner.Execute(expression);
        }

        public TResult Execute<TResult>(Expression expression)
        {
            return _inner.Execute<TResult>(expression);
        }

        public Task<object> ExecuteAsync(Expression expression, CancellationToken cancellationToken)
        {
            return Task.FromResult(Execute(expression));
        }

        public Task<TResult> ExecuteAsync<TResult>(Expression expression, CancellationToken cancellationToken)
        {
            if (expression is MethodCallExpression m)
            {
                if (m.Method.Name == "AnyAsync" && m.Arguments.Count == 2)
                {
                    var source = m.Arguments[0];
                    var predicate = m.Arguments[1];
                    var anyCall = Expression.Call(
                        typeof(Queryable), "Any", m.Method.GetGenericArguments(), source, predicate);
                    return Task.FromResult(_inner.Execute<TResult>(anyCall));
                }
                if (m.Method.Name == "FirstOrDefaultAsync" && m.Arguments.Count == 2)
                {
                    var source = m.Arguments[0];
                    var predicate = m.Arguments[1];
                    var firstOrDefaultCall = Expression.Call(
                       typeof(Queryable), "FirstOrDefault", m.Method.GetGenericArguments(), source, predicate);
                    return Task.FromResult(_inner.Execute<TResult>(firstOrDefaultCall));
                }
                if (m.Method.Name == "SaveChangesAsync" && m.Arguments.Count == 0) 
                {
                    object result = 1;
                    return Task.FromResult((TResult)result); 
                }
                if (m.Method.Name == "SaveChangesAsync" && m.Arguments.Count == 1)
                {
                    object result = 1;
                    return Task.FromResult((TResult)result);
                }
            }
            return Task.FromResult(Execute<TResult>(expression));
        }
    }

    internal class TestDbAsyncEnumerable<T> : EnumerableQuery<T>, IDbAsyncEnumerable<T>, IQueryable<T>
    {
        public TestDbAsyncEnumerable(IEnumerable<T> enumerable)
            : base(enumerable)
        { }

        public TestDbAsyncEnumerable(Expression expression)
            : base(expression)
        { }

        public IDbAsyncEnumerator<T> GetAsyncEnumerator()
        {
            return new TestDbAsyncEnumerator<T>(this.AsEnumerable().GetEnumerator());
        }

        IDbAsyncEnumerator IDbAsyncEnumerable.GetAsyncEnumerator()
        {
            return GetAsyncEnumerator();
        }

        IQueryProvider IQueryable.Provider => new TestDbAsyncQueryProvider<T>(this);
    }

    internal class TestDbAsyncEnumerator<T> : IDbAsyncEnumerator<T>
    {
        private readonly IEnumerator<T> _inner;

        public TestDbAsyncEnumerator(IEnumerator<T> inner)
        {
            _inner = inner;
        }

        public void Dispose()
        {
            _inner.Dispose();
        }

        public Task<bool> MoveNextAsync(CancellationToken cancellationToken)
        {
            return Task.FromResult(_inner.MoveNext());
        }

        public T Current => _inner.Current;

        object IDbAsyncEnumerator.Current => Current;
    }
    internal class MockDbSetHelpers
    {
    }
}
